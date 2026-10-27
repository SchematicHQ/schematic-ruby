# frozen_string_literal: true

require "json"
require "minitest/autorun"
require_relative "../lib/schematic/context_signature"

# testdata/context-signing.json is copied verbatim from
# api/lib/contextsig/testdata in the Schematic API, which generates it from the
# verifier and checks it in its own tests. Don't edit it here.
class ContextSignatureVectorsTest < Minitest::Test
  VECTORS = JSON.parse(File.read(File.join(__dir__, "testdata", "context-signing.json")))

  def test_caps_the_lifetime_where_the_api_does
    assert_equal VECTORS["max_lifetime_seconds"], Schematic::ContextSignature::MAX_LIFETIME_SECONDS
  end

  VECTORS["vectors"].each do |v|
    define_method("test_vector_#{v["name"]}") do
      company = v["context"]["company"]
      user = v["context"]["user"]

      assert_equal v["canonical"], Schematic::ContextSignature.canonicalize(company: company, user: user)
      assert_equal v["signature"],
                   Schematic::ContextSignature.sign_at(v["secret"], v["iat"], v["exp"], company: company, user: user)
    end
  end
end

class ContextSignatureSignTest < Minitest::Test
  CS = Schematic::ContextSignature
  COMPANY = { "id" => "comp_1" }.freeze

  def window(signature)
    signature.split(".").first(2).map { |part| Integer(part) }
  end

  def test_signs_for_the_default_lifetime_from_now
    before = Time.now.to_i
    iat, exp = window(CS.sign("secret", company: COMPANY))

    assert_operator iat, :>=, before
    assert_operator iat, :<=, Time.now.to_i
    assert_equal CS::DEFAULT_LIFETIME_SECONDS, exp - iat
  end

  def test_signs_from_the_time_and_for_the_lifetime_given
    signature = CS.sign("secret", company: COMPANY, issued_at: Time.at(1_700_000_000.5), lifetime_seconds: 300)

    assert_equal CS.sign_at("secret", 1_700_000_000, 1_700_000_300, company: COMPANY), signature
  end

  def test_refuses_a_lifetime_the_api_would_reject
    [0, -60, 1.5, CS::MAX_LIFETIME_SECONDS + 1, 86_400, "600"].each do |lifetime_seconds|
      assert_raises(CS::ContextSignatureError, lifetime_seconds.inspect) do
        CS.sign("secret", company: COMPANY, lifetime_seconds: lifetime_seconds)
      end
    end
  end

  def test_refuses_a_missing_secret
    assert_raises(CS::ContextSignatureError) { CS.sign("", company: COMPANY) }
    assert_raises(CS::ContextSignatureError) { CS.sign(nil, company: COMPANY) }
  end

  def test_refuses_a_value_that_isnt_a_string
    assert_raises(CS::ContextSignatureError) { CS.sign("secret", company: { "id" => 123 }) }
    assert_raises(CS::ContextSignatureError) { CS.sign("secret", company: { "id" => :comp_1 }) }
  end

  def test_refuses_keys_that_arent_a_hash
    assert_raises(CS::ContextSignatureError) { CS.sign("secret", company: "comp_1") }
  end

  def test_refuses_a_key_given_twice
    assert_raises(CS::ContextSignatureError) { CS.sign("secret", company: { "id" => "a", id: "b" }) }
  end
end

class ContextSignatureCanonicalizeTest < Minitest::Test
  CS = Schematic::ContextSignature

  def test_leaves_out_a_company_or_user_that_is_nil
    assert_equal "{}", CS.canonicalize(company: nil, user: nil)
  end

  def test_signs_symbol_key_names_as_strings
    assert_equal CS.canonicalize(company: { "id" => "comp_1" }), CS.canonicalize(company: { id: "comp_1" })
  end

  def test_signs_invalid_utf8_as_u_fffd_per_byte_as_the_api_reads_it
    assert_equal "{\"company\":{\"name\":\"a\uFFFDb\"}}",
                 CS.canonicalize(company: { "name" => "a\xFFb".b })
    assert_equal "{\"company\":{\"name\":\"a\uFFFD\uFFFD\uFFFD\"}}",
                 CS.canonicalize(company: { "name" => "a\xED\xA0\x80".dup.force_encoding(Encoding::UTF_8) })
  end

  def test_converts_other_encodings_to_utf8
    assert_equal "{\"company\":{\"name\":\"Caf\u00e9\"}}",
                 CS.canonicalize(company: { "name" => "Caf\u00e9".encode(Encoding::ISO_8859_1) })
  end
end
