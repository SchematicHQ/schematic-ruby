# frozen_string_literal: true

module Schematic
  module Types
    module TaxIdType
      extend Schematic::Internal::Types::Enum

      AE_TRN = "ae_trn"
      AU_ABN = "au_abn"
      AU_ARN = "au_arn"
      BR_CNPJ = "br_cnpj"
      BR_CPF = "br_cpf"
      CA_BN = "ca_bn"
      CA_GST_HST = "ca_gst_hst"
      CA_PST_BC = "ca_pst_bc"
      CA_PST_MB = "ca_pst_mb"
      CA_PST_SK = "ca_pst_sk"
      CA_QST = "ca_qst"
      CH_UID = "ch_uid"
      CH_VAT = "ch_vat"
      EU_VAT = "eu_vat"
      GB_VAT = "gb_vat"
      HK_BR = "hk_br"
      ID_NPWP = "id_npwp"
      IL_VAT = "il_vat"
      IN_GST = "in_gst"
      JP_CN = "jp_cn"
      JP_RN = "jp_rn"
      JP_TRN = "jp_trn"
      KR_BRN = "kr_brn"
      MX_RFC = "mx_rfc"
      MY_FRP = "my_frp"
      MY_ITN = "my_itn"
      MY_SST = "my_sst"
      NO_VAT = "no_vat"
      NZ_GST = "nz_gst"
      PH_TIN = "ph_tin"
      SA_VAT = "sa_vat"
      SG_GST = "sg_gst"
      SG_UEN = "sg_uen"
      TH_VAT = "th_vat"
      TR_TIN = "tr_tin"
      TW_VAT = "tw_vat"
      US_EIN = "us_ein"
      ZA_VAT = "za_vat"
    end
  end
end
