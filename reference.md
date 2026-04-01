# Reference
<details><summary><code>client.<a href="/lib/schematic/client.rb">put_plan_audiences_plan_audience_id</a>(plan_audience_id) -> </code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.put_plan_audiences_plan_audience_id(plan_audience_id: "plan_audience_id")
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**plan_audience_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.<a href="/lib/schematic/client.rb">delete_plan_audiences_plan_audience_id</a>(plan_audience_id) -> </code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.delete_plan_audiences_plan_audience_id(plan_audience_id: "plan_audience_id")
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**plan_audience_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## accounts
<details><summary><code>client.accounts.<a href="/lib/schematic/accounts/client.rb">list_api_keys</a>() -> Schematic::Accounts::Types::ListApiKeysResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.accounts.list_api_keys(
  environment_id: "environment_id",
  require_environment: true,
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**environment_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**require_environment:** `Internal::Types::Boolean` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Accounts::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.accounts.<a href="/lib/schematic/accounts/client.rb">create_api_key</a>(request) -> Schematic::Accounts::Types::CreateApiKeyResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.accounts.create_api_key(name: "name")
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**description:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**environment_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**name:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**readonly:** `Internal::Types::Boolean` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Accounts::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.accounts.<a href="/lib/schematic/accounts/client.rb">get_api_key</a>(api_key_id) -> Schematic::Accounts::Types::GetApiKeyResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.accounts.get_api_key(api_key_id: "api_key_id")
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**api_key_id:** `String` — api_key_id
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Accounts::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.accounts.<a href="/lib/schematic/accounts/client.rb">update_api_key</a>(api_key_id, request) -> Schematic::Accounts::Types::UpdateApiKeyResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.accounts.update_api_key(api_key_id: "api_key_id")
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**api_key_id:** `String` — api_key_id
    
</dd>
</dl>

<dl>
<dd>

**description:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**name:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Accounts::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.accounts.<a href="/lib/schematic/accounts/client.rb">delete_api_key</a>(api_key_id) -> Schematic::Accounts::Types::DeleteApiKeyResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.accounts.delete_api_key(api_key_id: "api_key_id")
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**api_key_id:** `String` — api_key_id
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Accounts::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.accounts.<a href="/lib/schematic/accounts/client.rb">count_api_keys</a>() -> Schematic::Accounts::Types::CountApiKeysResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.accounts.count_api_keys(
  environment_id: "environment_id",
  require_environment: true,
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**environment_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**require_environment:** `Internal::Types::Boolean` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Accounts::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.accounts.<a href="/lib/schematic/accounts/client.rb">list_audit_logs</a>() -> Schematic::Accounts::Types::ListAuditLogsResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.accounts.list_audit_logs(
  actor_type: "api_key",
  end_time: "2024-01-15T09:30:00Z",
  environment_id: "environment_id",
  q: "q",
  start_time: "2024-01-15T09:30:00Z",
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**actor_type:** `Schematic::Types::ActorType` 
    
</dd>
</dl>

<dl>
<dd>

**end_time:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**environment_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**q:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**start_time:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Accounts::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.accounts.<a href="/lib/schematic/accounts/client.rb">get_audit_log</a>(audit_log_id) -> Schematic::Accounts::Types::GetAuditLogResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.accounts.get_audit_log(audit_log_id: "audit_log_id")
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**audit_log_id:** `String` — audit_log_id
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Accounts::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.accounts.<a href="/lib/schematic/accounts/client.rb">count_audit_logs</a>() -> Schematic::Accounts::Types::CountAuditLogsResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.accounts.count_audit_logs(
  actor_type: "api_key",
  end_time: "2024-01-15T09:30:00Z",
  environment_id: "environment_id",
  q: "q",
  start_time: "2024-01-15T09:30:00Z",
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**actor_type:** `Schematic::Types::ActorType` 
    
</dd>
</dl>

<dl>
<dd>

**end_time:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**environment_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**q:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**start_time:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Accounts::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.accounts.<a href="/lib/schematic/accounts/client.rb">list_environments</a>() -> Schematic::Accounts::Types::ListEnvironmentsResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.accounts.list_environments(
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**ids:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Accounts::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.accounts.<a href="/lib/schematic/accounts/client.rb">create_environment</a>(request) -> Schematic::Accounts::Types::CreateEnvironmentResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.accounts.create_environment(
  environment_type: "development",
  name: "name"
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**environment_type:** `Schematic::Types::EnvironmentType` 
    
</dd>
</dl>

<dl>
<dd>

**name:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Accounts::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.accounts.<a href="/lib/schematic/accounts/client.rb">get_environment</a>(environment_id) -> Schematic::Accounts::Types::GetEnvironmentResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.accounts.get_environment(environment_id: "environment_id")
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**environment_id:** `String` — environment_id
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Accounts::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.accounts.<a href="/lib/schematic/accounts/client.rb">update_environment</a>(environment_id, request) -> Schematic::Accounts::Types::UpdateEnvironmentResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.accounts.update_environment(environment_id: "environment_id")
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**environment_id:** `String` — environment_id
    
</dd>
</dl>

<dl>
<dd>

**environment_type:** `Schematic::Types::EnvironmentType` 
    
</dd>
</dl>

<dl>
<dd>

**name:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Accounts::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.accounts.<a href="/lib/schematic/accounts/client.rb">delete_environment</a>(environment_id) -> Schematic::Accounts::Types::DeleteEnvironmentResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.accounts.delete_environment(environment_id: "environment_id")
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**environment_id:** `String` — environment_id
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Accounts::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.accounts.<a href="/lib/schematic/accounts/client.rb">quickstart</a>() -> Schematic::Accounts::Types::QuickstartResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.accounts.quickstart
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**request_options:** `Schematic::Accounts::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.accounts.<a href="/lib/schematic/accounts/client.rb">get_who_am_i</a>() -> Schematic::Accounts::Types::GetWhoAmIResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.accounts.get_who_am_i
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**request_options:** `Schematic::Accounts::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## billing
<details><summary><code>client.billing.<a href="/lib/schematic/billing/client.rb">list_coupons</a>() -> Schematic::Billing::Types::ListCouponsResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.billing.list_coupons(
  is_active: true,
  q: "q",
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**is_active:** `Internal::Types::Boolean` 
    
</dd>
</dl>

<dl>
<dd>

**q:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Billing::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.billing.<a href="/lib/schematic/billing/client.rb">upsert_billing_coupon</a>(request) -> Schematic::Billing::Types::UpsertBillingCouponResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.billing.upsert_billing_coupon(
  amount_off: 1000000,
  duration: "duration",
  duration_in_months: 1000000,
  external_id: "external_id",
  max_redemptions: 1000000,
  name: "name",
  percent_off: 1.1,
  times_redeemed: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**amount_off:** `Integer` 
    
</dd>
</dl>

<dl>
<dd>

**currency:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**duration:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**duration_in_months:** `Integer` 
    
</dd>
</dl>

<dl>
<dd>

**external_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**max_redemptions:** `Integer` 
    
</dd>
</dl>

<dl>
<dd>

**name:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**percent_off:** `Integer` 
    
</dd>
</dl>

<dl>
<dd>

**times_redeemed:** `Integer` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Billing::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.billing.<a href="/lib/schematic/billing/client.rb">upsert_billing_customer</a>(request) -> Schematic::Billing::Types::UpsertBillingCustomerResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.billing.upsert_billing_customer(
  email: "email",
  external_id: "external_id",
  meta: {
    key: "value"
  },
  name: "name"
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**company_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**default_payment_method_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**email:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**external_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**meta:** `Internal::Types::Hash[String, String]` 
    
</dd>
</dl>

<dl>
<dd>

**name:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**provider_type:** `Schematic::Types::BillingProviderType` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Billing::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.billing.<a href="/lib/schematic/billing/client.rb">list_customers_with_subscriptions</a>() -> Schematic::Billing::Types::ListCustomersWithSubscriptionsResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.billing.list_customers_with_subscriptions(
  name: "name",
  provider_type: "schematic",
  q: "q",
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**company_ids:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**name:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**provider_type:** `Schematic::Types::BillingProviderType` 
    
</dd>
</dl>

<dl>
<dd>

**q:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Billing::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.billing.<a href="/lib/schematic/billing/client.rb">count_customers</a>() -> Schematic::Billing::Types::CountCustomersResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.billing.count_customers(
  name: "name",
  provider_type: "schematic",
  q: "q",
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**company_ids:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**name:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**provider_type:** `Schematic::Types::BillingProviderType` 
    
</dd>
</dl>

<dl>
<dd>

**q:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Billing::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.billing.<a href="/lib/schematic/billing/client.rb">list_invoices</a>() -> Schematic::Billing::Types::ListInvoicesResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.billing.list_invoices(
  company_id: "company_id",
  customer_external_id: "customer_external_id",
  subscription_external_id: "subscription_external_id",
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**company_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**customer_external_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**subscription_external_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Billing::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.billing.<a href="/lib/schematic/billing/client.rb">upsert_invoice</a>(request) -> Schematic::Billing::Types::UpsertInvoiceResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.billing.upsert_invoice(
  amount_due: 1000000,
  amount_paid: 1000000,
  amount_remaining: 1000000,
  collection_method: "collection_method",
  currency: "currency",
  customer_external_id: "customer_external_id",
  subtotal: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**amount_due:** `Integer` 
    
</dd>
</dl>

<dl>
<dd>

**amount_paid:** `Integer` 
    
</dd>
</dl>

<dl>
<dd>

**amount_remaining:** `Integer` 
    
</dd>
</dl>

<dl>
<dd>

**collection_method:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**currency:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**customer_external_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**due_date:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**external_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**payment_method_external_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**status:** `Schematic::Types::InvoiceStatus` 
    
</dd>
</dl>

<dl>
<dd>

**subscription_external_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**subtotal:** `Integer` 
    
</dd>
</dl>

<dl>
<dd>

**url:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Billing::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.billing.<a href="/lib/schematic/billing/client.rb">list_meters</a>() -> Schematic::Billing::Types::ListMetersResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.billing.list_meters(
  display_name: "display_name",
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**display_name:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Billing::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.billing.<a href="/lib/schematic/billing/client.rb">upsert_billing_meter</a>(request) -> Schematic::Billing::Types::UpsertBillingMeterResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.billing.upsert_billing_meter(
  display_name: "display_name",
  event_name: "event_name",
  event_payload_key: "event_payload_key",
  external_id: "external_id"
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**display_name:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**event_name:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**event_payload_key:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**external_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Billing::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.billing.<a href="/lib/schematic/billing/client.rb">list_payment_methods</a>() -> Schematic::Billing::Types::ListPaymentMethodsResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.billing.list_payment_methods(
  company_id: "company_id",
  customer_external_id: "customer_external_id",
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**company_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**customer_external_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Billing::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.billing.<a href="/lib/schematic/billing/client.rb">upsert_payment_method</a>(request) -> Schematic::Billing::Types::UpsertPaymentMethodResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.billing.upsert_payment_method(
  customer_external_id: "customer_external_id",
  external_id: "external_id",
  payment_method_type: "payment_method_type"
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**account_last_4:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**account_name:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**bank_name:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**billing_email:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**billing_name:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**card_brand:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**card_exp_month:** `Integer` 
    
</dd>
</dl>

<dl>
<dd>

**card_exp_year:** `Integer` 
    
</dd>
</dl>

<dl>
<dd>

**card_last_4:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**customer_external_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**external_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**payment_method_type:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Billing::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.billing.<a href="/lib/schematic/billing/client.rb">list_billing_prices</a>() -> Schematic::Billing::Types::ListBillingPricesResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.billing.list_billing_prices(
  currency: "currency",
  for_initial_plan: true,
  for_trial_expiry_plan: true,
  interval: "interval",
  is_active: true,
  price: 1000000,
  product_id: "product_id",
  provider_type: "schematic",
  q: "q",
  tiers_mode: "graduated",
  usage_type: "licensed",
  with_meter: true,
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**currency:** `String` — Filter for prices in a specific currency (e.g. usd, eur)
    
</dd>
</dl>

<dl>
<dd>

**for_initial_plan:** `Internal::Types::Boolean` — Filter for prices valid for initial plans (free prices only)
    
</dd>
</dl>

<dl>
<dd>

**for_trial_expiry_plan:** `Internal::Types::Boolean` — Filter for prices valid for trial expiry plans (free prices only)
    
</dd>
</dl>

<dl>
<dd>

**ids:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**interval:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**is_active:** `Internal::Types::Boolean` — Filter for active prices on active products (defaults to true if not specified)
    
</dd>
</dl>

<dl>
<dd>

**price:** `Integer` 
    
</dd>
</dl>

<dl>
<dd>

**product_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**product_ids:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**provider_type:** `Schematic::Types::BillingProviderType` 
    
</dd>
</dl>

<dl>
<dd>

**q:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**tiers_mode:** `Schematic::Types::BillingTiersMode` 
    
</dd>
</dl>

<dl>
<dd>

**usage_type:** `Schematic::Types::BillingPriceUsageType` 
    
</dd>
</dl>

<dl>
<dd>

**with_meter:** `Internal::Types::Boolean` — Filter for prices with a meter
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Billing::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.billing.<a href="/lib/schematic/billing/client.rb">upsert_billing_price</a>(request) -> Schematic::Billing::Types::UpsertBillingPriceResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.billing.upsert_billing_price(
  billing_scheme: "per_unit",
  currency: "currency",
  external_account_id: "external_account_id",
  interval: "interval",
  is_active: true,
  price: 1000000,
  price_external_id: "price_external_id",
  price_tiers: [{
    price_external_id: "price_external_id"
  }],
  product_external_id: "product_external_id",
  usage_type: "licensed"
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**billing_scheme:** `Schematic::Types::BillingPriceScheme` 
    
</dd>
</dl>

<dl>
<dd>

**currency:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**external_account_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**interval:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**is_active:** `Internal::Types::Boolean` 
    
</dd>
</dl>

<dl>
<dd>

**meter_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**package_size:** `Integer` 
    
</dd>
</dl>

<dl>
<dd>

**price:** `Integer` 
    
</dd>
</dl>

<dl>
<dd>

**price_decimal:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**price_external_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**price_tiers:** `Internal::Types::Array[Schematic::Types::CreateBillingPriceTierRequestBody]` 
    
</dd>
</dl>

<dl>
<dd>

**product_external_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**provider_type:** `Schematic::Types::BillingProviderType` 
    
</dd>
</dl>

<dl>
<dd>

**tiers_mode:** `Schematic::Types::BillingTiersMode` 
    
</dd>
</dl>

<dl>
<dd>

**usage_type:** `Schematic::Types::BillingPriceUsageType` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Billing::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.billing.<a href="/lib/schematic/billing/client.rb">delete_billing_product</a>(billing_id) -> Schematic::Billing::Types::DeleteBillingProductResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.billing.delete_billing_product(billing_id: "billing_id")
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**billing_id:** `String` — billing_id
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Billing::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.billing.<a href="/lib/schematic/billing/client.rb">list_billing_product_prices</a>() -> Schematic::Billing::Types::ListBillingProductPricesResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.billing.list_billing_product_prices(
  currency: "currency",
  for_initial_plan: true,
  for_trial_expiry_plan: true,
  interval: "interval",
  is_active: true,
  price: 1000000,
  product_id: "product_id",
  provider_type: "schematic",
  q: "q",
  tiers_mode: "graduated",
  usage_type: "licensed",
  with_meter: true,
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**currency:** `String` — Filter for prices in a specific currency (e.g. usd, eur)
    
</dd>
</dl>

<dl>
<dd>

**for_initial_plan:** `Internal::Types::Boolean` — Filter for prices valid for initial plans (free prices only)
    
</dd>
</dl>

<dl>
<dd>

**for_trial_expiry_plan:** `Internal::Types::Boolean` — Filter for prices valid for trial expiry plans (free prices only)
    
</dd>
</dl>

<dl>
<dd>

**ids:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**interval:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**is_active:** `Internal::Types::Boolean` — Filter for active prices on active products (defaults to true if not specified)
    
</dd>
</dl>

<dl>
<dd>

**price:** `Integer` 
    
</dd>
</dl>

<dl>
<dd>

**product_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**product_ids:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**provider_type:** `Schematic::Types::BillingProviderType` 
    
</dd>
</dl>

<dl>
<dd>

**q:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**tiers_mode:** `Schematic::Types::BillingTiersMode` 
    
</dd>
</dl>

<dl>
<dd>

**usage_type:** `Schematic::Types::BillingPriceUsageType` 
    
</dd>
</dl>

<dl>
<dd>

**with_meter:** `Internal::Types::Boolean` — Filter for prices with a meter
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Billing::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.billing.<a href="/lib/schematic/billing/client.rb">delete_product_price</a>(billing_id) -> Schematic::Billing::Types::DeleteProductPriceResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.billing.delete_product_price(billing_id: "billing_id")
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**billing_id:** `String` — billing_id
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Billing::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.billing.<a href="/lib/schematic/billing/client.rb">upsert_billing_product</a>(request) -> Schematic::Billing::Types::UpsertBillingProductResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.billing.upsert_billing_product(
  external_id: "external_id",
  price: 1.1
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**external_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**is_active:** `Internal::Types::Boolean` 
    
</dd>
</dl>

<dl>
<dd>

**name:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**price:** `Integer` 
    
</dd>
</dl>

<dl>
<dd>

**provider_type:** `Schematic::Types::BillingProviderType` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Billing::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.billing.<a href="/lib/schematic/billing/client.rb">list_billing_products</a>() -> Schematic::Billing::Types::ListBillingProductsResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.billing.list_billing_products(
  is_active: true,
  name: "name",
  price_usage_type: "licensed",
  provider_type: "schematic",
  q: "q",
  with_one_time_charges: true,
  with_prices_only: true,
  with_zero_price: true,
  without_linked_to_plan: true,
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**ids:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**is_active:** `Internal::Types::Boolean` — Filter products that are active. Defaults to true if not specified
    
</dd>
</dl>

<dl>
<dd>

**name:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**price_usage_type:** `Schematic::Types::BillingPriceUsageType` 
    
</dd>
</dl>

<dl>
<dd>

**provider_type:** `Schematic::Types::BillingProviderType` 
    
</dd>
</dl>

<dl>
<dd>

**q:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**with_one_time_charges:** `Internal::Types::Boolean` — Filter products that are one time charges
    
</dd>
</dl>

<dl>
<dd>

**with_prices_only:** `Internal::Types::Boolean` — Filter products that have prices
    
</dd>
</dl>

<dl>
<dd>

**with_zero_price:** `Internal::Types::Boolean` — Filter products that have zero price for free subscription type
    
</dd>
</dl>

<dl>
<dd>

**without_linked_to_plan:** `Internal::Types::Boolean` — Filter products that are not linked to any plan
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Billing::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.billing.<a href="/lib/schematic/billing/client.rb">count_billing_products</a>() -> Schematic::Billing::Types::CountBillingProductsResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.billing.count_billing_products(
  is_active: true,
  name: "name",
  price_usage_type: "licensed",
  provider_type: "schematic",
  q: "q",
  with_one_time_charges: true,
  with_prices_only: true,
  with_zero_price: true,
  without_linked_to_plan: true,
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**ids:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**is_active:** `Internal::Types::Boolean` — Filter products that are active. Defaults to true if not specified
    
</dd>
</dl>

<dl>
<dd>

**name:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**price_usage_type:** `Schematic::Types::BillingPriceUsageType` 
    
</dd>
</dl>

<dl>
<dd>

**provider_type:** `Schematic::Types::BillingProviderType` 
    
</dd>
</dl>

<dl>
<dd>

**q:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**with_one_time_charges:** `Internal::Types::Boolean` — Filter products that are one time charges
    
</dd>
</dl>

<dl>
<dd>

**with_prices_only:** `Internal::Types::Boolean` — Filter products that have prices
    
</dd>
</dl>

<dl>
<dd>

**with_zero_price:** `Internal::Types::Boolean` — Filter products that have zero price for free subscription type
    
</dd>
</dl>

<dl>
<dd>

**without_linked_to_plan:** `Internal::Types::Boolean` — Filter products that are not linked to any plan
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Billing::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.billing.<a href="/lib/schematic/billing/client.rb">upsert_billing_subscription</a>(request) -> Schematic::Billing::Types::UpsertBillingSubscriptionResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.billing.upsert_billing_subscription(
  cancel_at_period_end: true,
  currency: "currency",
  customer_external_id: "customer_external_id",
  discounts: [{
    coupon_external_id: "coupon_external_id",
    external_id: "external_id",
    is_active: true,
    started_at: "2024-01-15T09:30:00Z"
  }],
  expired_at: "2024-01-15T09:30:00Z",
  product_external_ids: [{
    currency: "currency",
    interval: "interval",
    price: 1000000,
    price_external_id: "price_external_id",
    product_external_id: "product_external_id",
    quantity: 1000000,
    usage_type: "licensed"
  }],
  subscription_external_id: "subscription_external_id",
  total_price: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**application_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**cancel_at:** `Integer` 
    
</dd>
</dl>

<dl>
<dd>

**cancel_at_period_end:** `Internal::Types::Boolean` 
    
</dd>
</dl>

<dl>
<dd>

**currency:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**customer_external_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**default_payment_method_external_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**default_payment_method_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**discounts:** `Internal::Types::Array[Schematic::Types::BillingSubscriptionDiscount]` 
    
</dd>
</dl>

<dl>
<dd>

**expired_at:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**interval:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**metadata:** `Internal::Types::Hash[String, Object]` 
    
</dd>
</dl>

<dl>
<dd>

**period_end:** `Integer` 
    
</dd>
</dl>

<dl>
<dd>

**period_start:** `Integer` 
    
</dd>
</dl>

<dl>
<dd>

**product_external_ids:** `Internal::Types::Array[Schematic::Types::BillingProductPricing]` 
    
</dd>
</dl>

<dl>
<dd>

**status:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**subscription_external_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**total_price:** `Integer` 
    
</dd>
</dl>

<dl>
<dd>

**trial_end:** `Integer` 
    
</dd>
</dl>

<dl>
<dd>

**trial_end_setting:** `Schematic::Types::BillingSubscriptionTrialEndSetting` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Billing::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## credits
<details><summary><code>client.credits.<a href="/lib/schematic/credits/client.rb">list_billing_credits</a>() -> Schematic::Credits::Types::ListBillingCreditsResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.credits.list_billing_credits(
  name: "name",
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**ids:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**name:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Credits::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.credits.<a href="/lib/schematic/credits/client.rb">create_billing_credit</a>(request) -> Schematic::Credits::Types::CreateBillingCreditResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.credits.create_billing_credit(
  currency: "currency",
  description: "description",
  name: "name"
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**burn_strategy:** `Schematic::Types::BillingCreditBurnStrategy` 
    
</dd>
</dl>

<dl>
<dd>

**currency:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**currency_prices:** `Internal::Types::Array[Schematic::Types::CreditCurrencyPriceRequestBody]` 
    
</dd>
</dl>

<dl>
<dd>

**default_expiry_unit:** `Schematic::Types::BillingCreditExpiryUnit` 
    
</dd>
</dl>

<dl>
<dd>

**default_expiry_unit_count:** `Integer` 
    
</dd>
</dl>

<dl>
<dd>

**default_rollover_policy:** `Schematic::Types::BillingCreditRolloverPolicy` 
    
</dd>
</dl>

<dl>
<dd>

**description:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**icon:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**name:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**per_unit_price:** `Integer` 
    
</dd>
</dl>

<dl>
<dd>

**per_unit_price_decimal:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**plural_name:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**singular_name:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Credits::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.credits.<a href="/lib/schematic/credits/client.rb">get_single_billing_credit</a>(credit_id) -> Schematic::Credits::Types::GetSingleBillingCreditResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.credits.get_single_billing_credit(credit_id: "credit_id")
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**credit_id:** `String` — credit_id
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Credits::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.credits.<a href="/lib/schematic/credits/client.rb">update_billing_credit</a>(credit_id, request) -> Schematic::Credits::Types::UpdateBillingCreditResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.credits.update_billing_credit(
  credit_id: "credit_id",
  description: "description",
  name: "name"
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**credit_id:** `String` — credit_id
    
</dd>
</dl>

<dl>
<dd>

**burn_strategy:** `Schematic::Types::BillingCreditBurnStrategy` 
    
</dd>
</dl>

<dl>
<dd>

**currency_prices:** `Internal::Types::Array[Schematic::Types::CreditCurrencyPriceRequestBody]` 
    
</dd>
</dl>

<dl>
<dd>

**default_expiry_unit:** `Schematic::Types::BillingCreditExpiryUnit` 
    
</dd>
</dl>

<dl>
<dd>

**default_expiry_unit_count:** `Integer` 
    
</dd>
</dl>

<dl>
<dd>

**default_rollover_policy:** `Schematic::Types::BillingCreditRolloverPolicy` 
    
</dd>
</dl>

<dl>
<dd>

**description:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**icon:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**name:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**per_unit_price:** `Integer` 
    
</dd>
</dl>

<dl>
<dd>

**per_unit_price_decimal:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**plural_name:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**singular_name:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Credits::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.credits.<a href="/lib/schematic/credits/client.rb">soft_delete_billing_credit</a>(credit_id) -> Schematic::Credits::Types::SoftDeleteBillingCreditResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.credits.soft_delete_billing_credit(credit_id: "credit_id")
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**credit_id:** `String` — credit_id
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Credits::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.credits.<a href="/lib/schematic/credits/client.rb">list_credit_bundles</a>() -> Schematic::Credits::Types::ListCreditBundlesResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.credits.list_credit_bundles(
  credit_id: "credit_id",
  status: "active",
  bundle_type: "fixed",
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**ids:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**credit_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**status:** `Schematic::Types::BillingCreditBundleStatus` 
    
</dd>
</dl>

<dl>
<dd>

**bundle_type:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Credits::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.credits.<a href="/lib/schematic/credits/client.rb">create_credit_bundle</a>(request) -> Schematic::Credits::Types::CreateCreditBundleResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.credits.create_credit_bundle(
  bundle_name: "bundle_name",
  credit_id: "credit_id",
  currency: "currency",
  price_per_unit: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**bundle_name:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**bundle_type:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**credit_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**currency:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**currency_prices:** `Internal::Types::Array[Schematic::Types::CreditBundleCurrencyPriceRequestBody]` 
    
</dd>
</dl>

<dl>
<dd>

**expiry_type:** `Schematic::Types::BillingCreditExpiryType` 
    
</dd>
</dl>

<dl>
<dd>

**expiry_unit:** `Schematic::Types::BillingCreditExpiryUnit` 
    
</dd>
</dl>

<dl>
<dd>

**expiry_unit_count:** `Integer` 
    
</dd>
</dl>

<dl>
<dd>

**price_per_unit:** `Integer` 
    
</dd>
</dl>

<dl>
<dd>

**price_per_unit_decimal:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**quantity:** `Integer` 
    
</dd>
</dl>

<dl>
<dd>

**status:** `Schematic::Types::BillingCreditBundleStatus` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Credits::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.credits.<a href="/lib/schematic/credits/client.rb">get_credit_bundle</a>(bundle_id) -> Schematic::Credits::Types::GetCreditBundleResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.credits.get_credit_bundle(bundle_id: "bundle_id")
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**bundle_id:** `String` — bundle_id
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Credits::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.credits.<a href="/lib/schematic/credits/client.rb">update_credit_bundle_details</a>(bundle_id, request) -> Schematic::Credits::Types::UpdateCreditBundleDetailsResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.credits.update_credit_bundle_details(
  bundle_id: "bundle_id",
  bundle_name: "bundle_name",
  price_per_unit: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**bundle_id:** `String` — bundle_id
    
</dd>
</dl>

<dl>
<dd>

**bundle_name:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**currency_prices:** `Internal::Types::Array[Schematic::Types::CreditBundleCurrencyPriceRequestBody]` 
    
</dd>
</dl>

<dl>
<dd>

**expiry_type:** `Schematic::Types::BillingCreditExpiryType` 
    
</dd>
</dl>

<dl>
<dd>

**expiry_unit:** `Schematic::Types::BillingCreditExpiryUnit` 
    
</dd>
</dl>

<dl>
<dd>

**expiry_unit_count:** `Integer` 
    
</dd>
</dl>

<dl>
<dd>

**price_per_unit:** `Integer` 
    
</dd>
</dl>

<dl>
<dd>

**price_per_unit_decimal:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**quantity:** `Integer` 
    
</dd>
</dl>

<dl>
<dd>

**status:** `Schematic::Types::BillingCreditBundleStatus` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Credits::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.credits.<a href="/lib/schematic/credits/client.rb">delete_credit_bundle</a>(bundle_id) -> Schematic::Credits::Types::DeleteCreditBundleResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.credits.delete_credit_bundle(bundle_id: "bundle_id")
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**bundle_id:** `String` — bundle_id
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Credits::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.credits.<a href="/lib/schematic/credits/client.rb">count_credit_bundles</a>() -> Schematic::Credits::Types::CountCreditBundlesResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.credits.count_credit_bundles(
  credit_id: "credit_id",
  status: "active",
  bundle_type: "fixed",
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**ids:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**credit_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**status:** `Schematic::Types::BillingCreditBundleStatus` 
    
</dd>
</dl>

<dl>
<dd>

**bundle_type:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Credits::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.credits.<a href="/lib/schematic/credits/client.rb">count_billing_credits</a>() -> Schematic::Credits::Types::CountBillingCreditsResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.credits.count_billing_credits(
  name: "name",
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**ids:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**name:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Credits::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.credits.<a href="/lib/schematic/credits/client.rb">zero_out_grant</a>(grant_id, request) -> Schematic::Credits::Types::ZeroOutGrantResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.credits.zero_out_grant(grant_id: "grant_id")
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**grant_id:** `String` — grant_id
    
</dd>
</dl>

<dl>
<dd>

**reason:** `Schematic::Types::BillingCreditGrantZeroedOutReason` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Credits::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.credits.<a href="/lib/schematic/credits/client.rb">grant_billing_credits_to_company</a>(request) -> Schematic::Credits::Types::GrantBillingCreditsToCompanyResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.credits.grant_billing_credits_to_company(
  company_id: "company_id",
  credit_id: "credit_id",
  quantity: 1000000,
  reason: "billing_credit_auto_topup"
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**billing_periods_count:** `Integer` 
    
</dd>
</dl>

<dl>
<dd>

**company_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**credit_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**currency:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**expires_at:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**expiry_type:** `Schematic::Types::BillingCreditExpiryType` 
    
</dd>
</dl>

<dl>
<dd>

**expiry_unit:** `Schematic::Types::BillingCreditExpiryUnit` 
    
</dd>
</dl>

<dl>
<dd>

**expiry_unit_count:** `Integer` 
    
</dd>
</dl>

<dl>
<dd>

**quantity:** `Integer` 
    
</dd>
</dl>

<dl>
<dd>

**reason:** `Schematic::Types::BillingCreditGrantReason` 
    
</dd>
</dl>

<dl>
<dd>

**renewal_enabled:** `Internal::Types::Boolean` 
    
</dd>
</dl>

<dl>
<dd>

**renewal_period:** `Schematic::Types::BillingPlanCreditGrantResetStart` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Credits::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.credits.<a href="/lib/schematic/credits/client.rb">count_company_grants</a>() -> Schematic::Credits::Types::CountCompanyGrantsResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.credits.count_company_grants(
  company_id: "company_id",
  order: "created_at",
  dir: "asc",
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**company_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**order:** `Schematic::Types::CreditGrantSortOrder` 
    
</dd>
</dl>

<dl>
<dd>

**dir:** `Schematic::Types::SortDirection` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Credits::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.credits.<a href="/lib/schematic/credits/client.rb">list_company_grants</a>() -> Schematic::Credits::Types::ListCompanyGrantsResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.credits.list_company_grants(
  company_id: "company_id",
  order: "created_at",
  dir: "asc",
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**company_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**order:** `Schematic::Types::CreditGrantSortOrder` 
    
</dd>
</dl>

<dl>
<dd>

**dir:** `Schematic::Types::SortDirection` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Credits::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.credits.<a href="/lib/schematic/credits/client.rb">count_billing_credits_grants</a>() -> Schematic::Credits::Types::CountBillingCreditsGrantsResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.credits.count_billing_credits_grants(
  credit_id: "credit_id",
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**credit_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**ids:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Credits::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.credits.<a href="/lib/schematic/credits/client.rb">list_grants_for_credit</a>() -> Schematic::Credits::Types::ListGrantsForCreditResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.credits.list_grants_for_credit(
  credit_id: "credit_id",
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**credit_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**ids:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Credits::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.credits.<a href="/lib/schematic/credits/client.rb">get_enriched_credit_ledger</a>() -> Schematic::Credits::Types::GetEnrichedCreditLedgerResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.credits.get_enriched_credit_ledger(
  company_id: "company_id",
  billing_credit_id: "billing_credit_id",
  feature_id: "feature_id",
  period: "daily",
  start_time: "start_time",
  end_time: "end_time",
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**company_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**billing_credit_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**feature_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**period:** `Schematic::Types::CreditLedgerPeriod` 
    
</dd>
</dl>

<dl>
<dd>

**start_time:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**end_time:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Credits::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.credits.<a href="/lib/schematic/credits/client.rb">count_credit_ledger</a>() -> Schematic::Credits::Types::CountCreditLedgerResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.credits.count_credit_ledger(
  company_id: "company_id",
  billing_credit_id: "billing_credit_id",
  feature_id: "feature_id",
  period: "daily",
  start_time: "start_time",
  end_time: "end_time",
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**company_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**billing_credit_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**feature_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**period:** `Schematic::Types::CreditLedgerPeriod` 
    
</dd>
</dl>

<dl>
<dd>

**start_time:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**end_time:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Credits::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.credits.<a href="/lib/schematic/credits/client.rb">list_billing_plan_credit_grants</a>() -> Schematic::Credits::Types::ListBillingPlanCreditGrantsResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.credits.list_billing_plan_credit_grants(
  credit_id: "credit_id",
  plan_id: "plan_id",
  plan_version_id: "plan_version_id",
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**credit_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**ids:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**plan_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**plan_ids:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**plan_version_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Credits::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.credits.<a href="/lib/schematic/credits/client.rb">create_billing_plan_credit_grant</a>(request) -> Schematic::Credits::Types::CreateBillingPlanCreditGrantResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.credits.create_billing_plan_credit_grant(
  credit_amount: 1000000,
  credit_id: "credit_id",
  plan_id: "plan_id",
  reset_cadence: "daily",
  reset_start: "billing_period"
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**request:** `Schematic::Types::CreateBillingPlanCreditGrantRequestBody` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Credits::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.credits.<a href="/lib/schematic/credits/client.rb">update_billing_plan_credit_grant</a>(plan_grant_id, request) -> Schematic::Credits::Types::UpdateBillingPlanCreditGrantResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.credits.update_billing_plan_credit_grant(
  plan_grant_id: "plan_grant_id",
  reset_cadence: "daily",
  reset_start: "billing_period"
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**plan_grant_id:** `String` — plan_grant_id
    
</dd>
</dl>

<dl>
<dd>

**request:** `Schematic::Types::UpdateBillingPlanCreditGrantRequestBody` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Credits::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.credits.<a href="/lib/schematic/credits/client.rb">delete_billing_plan_credit_grant</a>(plan_grant_id) -> Schematic::Credits::Types::DeleteBillingPlanCreditGrantResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.credits.delete_billing_plan_credit_grant(
  plan_grant_id: "plan_grant_id",
  apply_to_existing: true
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**plan_grant_id:** `String` — plan_grant_id
    
</dd>
</dl>

<dl>
<dd>

**apply_to_existing:** `Internal::Types::Boolean` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Credits::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.credits.<a href="/lib/schematic/credits/client.rb">count_billing_plan_credit_grants</a>() -> Schematic::Credits::Types::CountBillingPlanCreditGrantsResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.credits.count_billing_plan_credit_grants(
  credit_id: "credit_id",
  plan_id: "plan_id",
  plan_version_id: "plan_version_id",
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**credit_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**ids:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**plan_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**plan_ids:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**plan_version_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Credits::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.credits.<a href="/lib/schematic/credits/client.rb">list_credit_event_ledger</a>() -> Schematic::Credits::Types::ListCreditEventLedgerResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.credits.list_credit_event_ledger(
  billing_credit_id: "billing_credit_id",
  company_id: "company_id",
  end_time: "end_time",
  event_type: "grant",
  feature_id: "feature_id",
  start_time: "start_time",
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**billing_credit_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**company_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**end_time:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**event_type:** `Schematic::Types::CreditEventType` 
    
</dd>
</dl>

<dl>
<dd>

**feature_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**start_time:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Credits::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.credits.<a href="/lib/schematic/credits/client.rb">count_credit_event_ledger</a>() -> Schematic::Credits::Types::CountCreditEventLedgerResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.credits.count_credit_event_ledger(
  billing_credit_id: "billing_credit_id",
  company_id: "company_id",
  end_time: "end_time",
  event_type: "grant",
  feature_id: "feature_id",
  start_time: "start_time",
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**billing_credit_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**company_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**end_time:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**event_type:** `Schematic::Types::CreditEventType` 
    
</dd>
</dl>

<dl>
<dd>

**feature_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**start_time:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Credits::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## checkout
<details><summary><code>client.checkout.<a href="/lib/schematic/checkout/client.rb">internal</a>(request) -> Schematic::Checkout::Types::CheckoutInternalResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.checkout.internal(
  add_on_ids: [{
    add_on_id: "add_on_id",
    price_id: "price_id"
  }],
  company_id: "company_id",
  credit_bundles: [{
    bundle_id: "bundle_id",
    quantity: 1000000
  }],
  new_plan_id: "new_plan_id",
  new_price_id: "new_price_id",
  pay_in_advance: [{
    price_id: "price_id",
    quantity: 1000000
  }],
  skip_trial: true
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**request:** `Schematic::Types::ChangeSubscriptionInternalRequestBody` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Checkout::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.checkout.<a href="/lib/schematic/checkout/client.rb">get_checkout_data</a>(request) -> Schematic::Checkout::Types::GetCheckoutDataResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.checkout.get_checkout_data(company_id: "company_id")
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**company_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**selected_plan_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Checkout::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.checkout.<a href="/lib/schematic/checkout/client.rb">preview_checkout_internal</a>(request) -> Schematic::Checkout::Types::PreviewCheckoutInternalResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.checkout.preview_checkout_internal(
  add_on_ids: [{
    add_on_id: "add_on_id",
    price_id: "price_id"
  }],
  company_id: "company_id",
  credit_bundles: [{
    bundle_id: "bundle_id",
    quantity: 1000000
  }],
  new_plan_id: "new_plan_id",
  new_price_id: "new_price_id",
  pay_in_advance: [{
    price_id: "price_id",
    quantity: 1000000
  }],
  skip_trial: true
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**request:** `Schematic::Types::ChangeSubscriptionInternalRequestBody` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Checkout::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.checkout.<a href="/lib/schematic/checkout/client.rb">manage_plan</a>(request) -> Schematic::Checkout::Types::ManagePlanResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.checkout.manage_plan(
  add_on_selections: [{
    plan_id: "plan_id"
  }],
  company_id: "company_id",
  credit_bundles: [{
    bundle_id: "bundle_id",
    quantity: 1000000
  }],
  pay_in_advance_entitlements: [{
    price_id: "price_id",
    quantity: 1000000
  }]
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**request:** `Schematic::Types::ManagePlanRequest` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Checkout::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.checkout.<a href="/lib/schematic/checkout/client.rb">preview_manage_plan</a>(request) -> Schematic::Checkout::Types::PreviewManagePlanResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.checkout.preview_manage_plan(
  add_on_selections: [{
    plan_id: "plan_id"
  }],
  company_id: "company_id",
  credit_bundles: [{
    bundle_id: "bundle_id",
    quantity: 1000000
  }],
  pay_in_advance_entitlements: [{
    price_id: "price_id",
    quantity: 1000000
  }]
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**request:** `Schematic::Types::ManagePlanRequest` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Checkout::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.checkout.<a href="/lib/schematic/checkout/client.rb">cancel_subscription</a>(request) -> Schematic::Checkout::Types::CancelSubscriptionResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.checkout.cancel_subscription(company_id: "company_id")
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**cancel_immediately:** `Internal::Types::Boolean` — If false, subscription cancels at period end. Defaults to true.
    
</dd>
</dl>

<dl>
<dd>

**company_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**prorate:** `Internal::Types::Boolean` — If true and cancel_immediately is true, issue prorated credit. Defaults to true.
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Checkout::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.checkout.<a href="/lib/schematic/checkout/client.rb">update_customer_subscription_trial_end</a>(subscription_id, request) -> Schematic::Checkout::Types::UpdateCustomerSubscriptionTrialEndResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.checkout.update_customer_subscription_trial_end(subscription_id: "subscription_id")
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**subscription_id:** `String` — subscription_id
    
</dd>
</dl>

<dl>
<dd>

**trial_end:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Checkout::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## companies
<details><summary><code>client.companies.<a href="/lib/schematic/companies/client.rb">list_companies</a>() -> Schematic::Companies::Types::ListCompaniesResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.companies.list_companies(
  monetized_subscriptions: true,
  plan_id: "plan_id",
  plan_version_id: "plan_version_id",
  q: "q",
  sort_order_column: "sort_order_column",
  sort_order_direction: "asc",
  with_entitlement_for: "with_entitlement_for",
  without_feature_override_for: "without_feature_override_for",
  without_plan: true,
  without_subscription: true,
  with_subscription: true,
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**credit_type_ids:** `String` — Filter companies by one or more credit type IDs (each ID starts with bcrd_)
    
</dd>
</dl>

<dl>
<dd>

**ids:** `String` — Filter companies by multiple company IDs (starts with comp_)
    
</dd>
</dl>

<dl>
<dd>

**monetized_subscriptions:** `Internal::Types::Boolean` — Filter companies that have monetized subscriptions
    
</dd>
</dl>

<dl>
<dd>

**plan_id:** `String` — Filter companies by plan ID (starts with plan_)
    
</dd>
</dl>

<dl>
<dd>

**plan_ids:** `String` — Filter companies by one or more plan IDs (each ID starts with plan_)
    
</dd>
</dl>

<dl>
<dd>

**plan_version_id:** `String` — Filter companies by plan version ID (starts with plvr_)
    
</dd>
</dl>

<dl>
<dd>

**q:** `String` — Search for companies by name, keys or string traits
    
</dd>
</dl>

<dl>
<dd>

**sort_order_column:** `String` — Column to sort by (e.g. name, created_at, last_seen_at)
    
</dd>
</dl>

<dl>
<dd>

**sort_order_direction:** `Schematic::Types::SortDirection` — Direction to sort by (asc or desc)
    
</dd>
</dl>

<dl>
<dd>

**subscription_statuses:** `Schematic::Types::SubscriptionStatus` — Filter companies by one or more subscription statuses
    
</dd>
</dl>

<dl>
<dd>

**subscription_types:** `Schematic::Types::SubscriptionType` — Filter companies by one or more subscription types
    
</dd>
</dl>

<dl>
<dd>

**with_entitlement_for:** `String` — Filter companies that have an entitlement (plan entitlement or company override) for the specified feature ID
    
</dd>
</dl>

<dl>
<dd>

**without_feature_override_for:** `String` — Filter out companies that already have a company override for the specified feature ID
    
</dd>
</dl>

<dl>
<dd>

**without_plan:** `Internal::Types::Boolean` — Filter out companies that have a plan
    
</dd>
</dl>

<dl>
<dd>

**without_subscription:** `Internal::Types::Boolean` — Filter out companies that have a subscription
    
</dd>
</dl>

<dl>
<dd>

**with_subscription:** `Internal::Types::Boolean` — Filter companies that have a subscription
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Companies::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.companies.<a href="/lib/schematic/companies/client.rb">upsert_company</a>(request) -> Schematic::Companies::Types::UpsertCompanyResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.companies.upsert_company(keys: {
  key: "value"
})
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**request:** `Schematic::Types::UpsertCompanyRequestBody` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Companies::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.companies.<a href="/lib/schematic/companies/client.rb">get_company</a>(company_id) -> Schematic::Companies::Types::GetCompanyResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.companies.get_company(company_id: "company_id")
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**company_id:** `String` — company_id
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Companies::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.companies.<a href="/lib/schematic/companies/client.rb">delete_company</a>(company_id) -> Schematic::Companies::Types::DeleteCompanyResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.companies.delete_company(
  company_id: "company_id",
  cancel_subscription: true,
  prorate: true
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**company_id:** `String` — company_id
    
</dd>
</dl>

<dl>
<dd>

**cancel_subscription:** `Internal::Types::Boolean` 
    
</dd>
</dl>

<dl>
<dd>

**prorate:** `Internal::Types::Boolean` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Companies::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.companies.<a href="/lib/schematic/companies/client.rb">count_companies</a>() -> Schematic::Companies::Types::CountCompaniesResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.companies.count_companies(
  monetized_subscriptions: true,
  plan_id: "plan_id",
  plan_version_id: "plan_version_id",
  q: "q",
  sort_order_column: "sort_order_column",
  sort_order_direction: "asc",
  with_entitlement_for: "with_entitlement_for",
  without_feature_override_for: "without_feature_override_for",
  without_plan: true,
  without_subscription: true,
  with_subscription: true,
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**credit_type_ids:** `String` — Filter companies by one or more credit type IDs (each ID starts with bcrd_)
    
</dd>
</dl>

<dl>
<dd>

**ids:** `String` — Filter companies by multiple company IDs (starts with comp_)
    
</dd>
</dl>

<dl>
<dd>

**monetized_subscriptions:** `Internal::Types::Boolean` — Filter companies that have monetized subscriptions
    
</dd>
</dl>

<dl>
<dd>

**plan_id:** `String` — Filter companies by plan ID (starts with plan_)
    
</dd>
</dl>

<dl>
<dd>

**plan_ids:** `String` — Filter companies by one or more plan IDs (each ID starts with plan_)
    
</dd>
</dl>

<dl>
<dd>

**plan_version_id:** `String` — Filter companies by plan version ID (starts with plvr_)
    
</dd>
</dl>

<dl>
<dd>

**q:** `String` — Search for companies by name, keys or string traits
    
</dd>
</dl>

<dl>
<dd>

**sort_order_column:** `String` — Column to sort by (e.g. name, created_at, last_seen_at)
    
</dd>
</dl>

<dl>
<dd>

**sort_order_direction:** `Schematic::Types::SortDirection` — Direction to sort by (asc or desc)
    
</dd>
</dl>

<dl>
<dd>

**subscription_statuses:** `Schematic::Types::SubscriptionStatus` — Filter companies by one or more subscription statuses
    
</dd>
</dl>

<dl>
<dd>

**subscription_types:** `Schematic::Types::SubscriptionType` — Filter companies by one or more subscription types
    
</dd>
</dl>

<dl>
<dd>

**with_entitlement_for:** `String` — Filter companies that have an entitlement (plan entitlement or company override) for the specified feature ID
    
</dd>
</dl>

<dl>
<dd>

**without_feature_override_for:** `String` — Filter out companies that already have a company override for the specified feature ID
    
</dd>
</dl>

<dl>
<dd>

**without_plan:** `Internal::Types::Boolean` — Filter out companies that have a plan
    
</dd>
</dl>

<dl>
<dd>

**without_subscription:** `Internal::Types::Boolean` — Filter out companies that have a subscription
    
</dd>
</dl>

<dl>
<dd>

**with_subscription:** `Internal::Types::Boolean` — Filter companies that have a subscription
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Companies::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.companies.<a href="/lib/schematic/companies/client.rb">create_company</a>(request) -> Schematic::Companies::Types::CreateCompanyResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.companies.create_company(keys: {
  key: "value"
})
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**request:** `Schematic::Types::UpsertCompanyRequestBody` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Companies::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.companies.<a href="/lib/schematic/companies/client.rb">delete_company_by_keys</a>(request) -> Schematic::Companies::Types::DeleteCompanyByKeysResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.companies.delete_company_by_keys(keys: {
  key: "value"
})
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**request:** `Schematic::Types::KeysRequestBody` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Companies::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.companies.<a href="/lib/schematic/companies/client.rb">lookup_company</a>() -> Schematic::Companies::Types::LookupCompanyResponse</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Company lookup is determined to resolve a company from its keys, similar to how many of our other apis work. 
The following approaches will all work to resolve a company and any of them are appropriate:
1. `/companies/lookup?keys={"foo": "bar", "fizz": "buzz"}`
2. `/companies/lookup?keys[foo]=bar&keys[fizz]=buzz`
2. `/companies/lookup?foo=bar&fizz=buzz`
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.companies.lookup_company(keys: {
  keys: "keys"
})
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**keys:** `Internal::Types::Hash[String, String]` — Key/value pairs
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Companies::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.companies.<a href="/lib/schematic/companies/client.rb">list_company_memberships</a>() -> Schematic::Companies::Types::ListCompanyMembershipsResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.companies.list_company_memberships(
  company_id: "company_id",
  user_id: "user_id",
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**company_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**user_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Companies::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.companies.<a href="/lib/schematic/companies/client.rb">get_or_create_company_membership</a>(request) -> Schematic::Companies::Types::GetOrCreateCompanyMembershipResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.companies.get_or_create_company_membership(
  company_id: "company_id",
  user_id: "user_id"
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**company_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**user_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Companies::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.companies.<a href="/lib/schematic/companies/client.rb">delete_company_membership</a>(company_membership_id) -> Schematic::Companies::Types::DeleteCompanyMembershipResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.companies.delete_company_membership(company_membership_id: "company_membership_id")
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**company_membership_id:** `String` — company_membership_id
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Companies::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.companies.<a href="/lib/schematic/companies/client.rb">get_active_company_subscription</a>() -> Schematic::Companies::Types::GetActiveCompanySubscriptionResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.companies.get_active_company_subscription(
  company_id: "company_id",
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**company_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**company_ids:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Companies::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.companies.<a href="/lib/schematic/companies/client.rb">upsert_company_trait</a>(request) -> Schematic::Companies::Types::UpsertCompanyTraitResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.companies.upsert_company_trait(
  keys: {
    key: "value"
  },
  trait: "trait"
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**request:** `Schematic::Types::UpsertTraitRequestBody` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Companies::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.companies.<a href="/lib/schematic/companies/client.rb">list_entity_key_definitions</a>() -> Schematic::Companies::Types::ListEntityKeyDefinitionsResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.companies.list_entity_key_definitions(
  entity_type: "company",
  q: "q",
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**entity_type:** `Schematic::Types::EntityType` 
    
</dd>
</dl>

<dl>
<dd>

**ids:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**q:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Companies::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.companies.<a href="/lib/schematic/companies/client.rb">count_entity_key_definitions</a>() -> Schematic::Companies::Types::CountEntityKeyDefinitionsResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.companies.count_entity_key_definitions(
  entity_type: "company",
  q: "q",
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**entity_type:** `Schematic::Types::EntityType` 
    
</dd>
</dl>

<dl>
<dd>

**ids:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**q:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Companies::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.companies.<a href="/lib/schematic/companies/client.rb">list_entity_trait_definitions</a>() -> Schematic::Companies::Types::ListEntityTraitDefinitionsResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.companies.list_entity_trait_definitions(
  entity_type: "company",
  q: "q",
  trait_type: "boolean",
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**entity_type:** `Schematic::Types::EntityType` 
    
</dd>
</dl>

<dl>
<dd>

**ids:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**q:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**trait_type:** `Schematic::Types::TraitType` 
    
</dd>
</dl>

<dl>
<dd>

**trait_types:** `Schematic::Types::TraitType` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Companies::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.companies.<a href="/lib/schematic/companies/client.rb">get_or_create_entity_trait_definition</a>(request) -> Schematic::Companies::Types::GetOrCreateEntityTraitDefinitionResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.companies.get_or_create_entity_trait_definition(
  entity_type: "company",
  hierarchy: ["hierarchy"],
  trait_type: "boolean"
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**display_name:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**entity_type:** `Schematic::Types::EntityType` 
    
</dd>
</dl>

<dl>
<dd>

**hierarchy:** `Internal::Types::Array[String]` 
    
</dd>
</dl>

<dl>
<dd>

**trait_type:** `Schematic::Types::TraitType` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Companies::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.companies.<a href="/lib/schematic/companies/client.rb">get_entity_trait_definition</a>(entity_trait_definition_id) -> Schematic::Companies::Types::GetEntityTraitDefinitionResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.companies.get_entity_trait_definition(entity_trait_definition_id: "entity_trait_definition_id")
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**entity_trait_definition_id:** `String` — entity_trait_definition_id
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Companies::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.companies.<a href="/lib/schematic/companies/client.rb">update_entity_trait_definition</a>(entity_trait_definition_id, request) -> Schematic::Companies::Types::UpdateEntityTraitDefinitionResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.companies.update_entity_trait_definition(
  entity_trait_definition_id: "entity_trait_definition_id",
  trait_type: "boolean"
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**entity_trait_definition_id:** `String` — entity_trait_definition_id
    
</dd>
</dl>

<dl>
<dd>

**display_name:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**trait_type:** `Schematic::Types::TraitType` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Companies::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.companies.<a href="/lib/schematic/companies/client.rb">count_entity_trait_definitions</a>() -> Schematic::Companies::Types::CountEntityTraitDefinitionsResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.companies.count_entity_trait_definitions(
  entity_type: "company",
  q: "q",
  trait_type: "boolean",
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**entity_type:** `Schematic::Types::EntityType` 
    
</dd>
</dl>

<dl>
<dd>

**ids:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**q:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**trait_type:** `Schematic::Types::TraitType` 
    
</dd>
</dl>

<dl>
<dd>

**trait_types:** `Schematic::Types::TraitType` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Companies::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.companies.<a href="/lib/schematic/companies/client.rb">get_entity_trait_values</a>() -> Schematic::Companies::Types::GetEntityTraitValuesResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.companies.get_entity_trait_values(
  definition_id: "definition_id",
  q: "q",
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**definition_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**q:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Companies::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.companies.<a href="/lib/schematic/companies/client.rb">list_plan_changes</a>() -> Schematic::Companies::Types::ListPlanChangesResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.companies.list_plan_changes(
  action: "action",
  base_plan_action: "base_plan_action",
  company_id: "company_id",
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**action:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**base_plan_action:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**company_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**company_ids:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**plan_ids:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Companies::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.companies.<a href="/lib/schematic/companies/client.rb">get_plan_change</a>(plan_change_id) -> Schematic::Companies::Types::GetPlanChangeResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.companies.get_plan_change(plan_change_id: "plan_change_id")
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**plan_change_id:** `String` — plan_change_id
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Companies::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.companies.<a href="/lib/schematic/companies/client.rb">list_plan_traits</a>() -> Schematic::Companies::Types::ListPlanTraitsResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.companies.list_plan_traits(
  plan_id: "plan_id",
  trait_id: "trait_id",
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**ids:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**plan_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**trait_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**trait_ids:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Companies::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.companies.<a href="/lib/schematic/companies/client.rb">create_plan_trait</a>(request) -> Schematic::Companies::Types::CreatePlanTraitResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.companies.create_plan_trait(
  plan_id: "plan_id",
  trait_id: "trait_id",
  trait_value: "trait_value"
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**plan_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**trait_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**trait_value:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Companies::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.companies.<a href="/lib/schematic/companies/client.rb">get_plan_trait</a>(plan_trait_id) -> Schematic::Companies::Types::GetPlanTraitResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.companies.get_plan_trait(plan_trait_id: "plan_trait_id")
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**plan_trait_id:** `String` — plan_trait_id
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Companies::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.companies.<a href="/lib/schematic/companies/client.rb">update_plan_trait</a>(plan_trait_id, request) -> Schematic::Companies::Types::UpdatePlanTraitResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.companies.update_plan_trait(
  plan_trait_id: "plan_trait_id",
  plan_id: "plan_id",
  trait_value: "trait_value"
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**plan_trait_id:** `String` — plan_trait_id
    
</dd>
</dl>

<dl>
<dd>

**plan_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**trait_value:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Companies::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.companies.<a href="/lib/schematic/companies/client.rb">delete_plan_trait</a>(plan_trait_id) -> Schematic::Companies::Types::DeletePlanTraitResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.companies.delete_plan_trait(plan_trait_id: "plan_trait_id")
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**plan_trait_id:** `String` — plan_trait_id
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Companies::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.companies.<a href="/lib/schematic/companies/client.rb">update_plan_traits_bulk</a>(request) -> Schematic::Companies::Types::UpdatePlanTraitsBulkResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.companies.update_plan_traits_bulk(
  apply_to_existing_companies: true,
  plan_id: "plan_id",
  traits: [{
    trait_id: "trait_id",
    trait_value: "trait_value"
  }]
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**apply_to_existing_companies:** `Internal::Types::Boolean` 
    
</dd>
</dl>

<dl>
<dd>

**plan_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**traits:** `Internal::Types::Array[Schematic::Types::UpdatePlanTraitTraitRequestBody]` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Companies::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.companies.<a href="/lib/schematic/companies/client.rb">count_plan_traits</a>() -> Schematic::Companies::Types::CountPlanTraitsResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.companies.count_plan_traits(
  plan_id: "plan_id",
  trait_id: "trait_id",
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**ids:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**plan_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**trait_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**trait_ids:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Companies::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.companies.<a href="/lib/schematic/companies/client.rb">upsert_user_trait</a>(request) -> Schematic::Companies::Types::UpsertUserTraitResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.companies.upsert_user_trait(
  keys: {
    key: "value"
  },
  trait: "trait"
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**request:** `Schematic::Types::UpsertTraitRequestBody` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Companies::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.companies.<a href="/lib/schematic/companies/client.rb">list_users</a>() -> Schematic::Companies::Types::ListUsersResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.companies.list_users(
  company_id: "company_id",
  plan_id: "plan_id",
  q: "q",
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**company_id:** `String` — Filter users by company ID (starts with comp_)
    
</dd>
</dl>

<dl>
<dd>

**ids:** `String` — Filter users by multiple user IDs (starts with user_)
    
</dd>
</dl>

<dl>
<dd>

**plan_id:** `String` — Filter users by plan ID (starts with plan_)
    
</dd>
</dl>

<dl>
<dd>

**q:** `String` — Search for users by name, keys or string traits
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Companies::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.companies.<a href="/lib/schematic/companies/client.rb">upsert_user</a>(request) -> Schematic::Companies::Types::UpsertUserResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.companies.upsert_user(keys: {
  key: "value"
})
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**request:** `Schematic::Types::UpsertUserRequestBody` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Companies::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.companies.<a href="/lib/schematic/companies/client.rb">get_user</a>(user_id) -> Schematic::Companies::Types::GetUserResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.companies.get_user(user_id: "user_id")
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**user_id:** `String` — user_id
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Companies::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.companies.<a href="/lib/schematic/companies/client.rb">delete_user</a>(user_id) -> Schematic::Companies::Types::DeleteUserResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.companies.delete_user(user_id: "user_id")
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**user_id:** `String` — user_id
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Companies::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.companies.<a href="/lib/schematic/companies/client.rb">count_users</a>() -> Schematic::Companies::Types::CountUsersResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.companies.count_users(
  company_id: "company_id",
  plan_id: "plan_id",
  q: "q",
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**company_id:** `String` — Filter users by company ID (starts with comp_)
    
</dd>
</dl>

<dl>
<dd>

**ids:** `String` — Filter users by multiple user IDs (starts with user_)
    
</dd>
</dl>

<dl>
<dd>

**plan_id:** `String` — Filter users by plan ID (starts with plan_)
    
</dd>
</dl>

<dl>
<dd>

**q:** `String` — Search for users by name, keys or string traits
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Companies::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.companies.<a href="/lib/schematic/companies/client.rb">create_user</a>(request) -> Schematic::Companies::Types::CreateUserResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.companies.create_user(keys: {
  key: "value"
})
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**request:** `Schematic::Types::UpsertUserRequestBody` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Companies::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.companies.<a href="/lib/schematic/companies/client.rb">delete_user_by_keys</a>(request) -> Schematic::Companies::Types::DeleteUserByKeysResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.companies.delete_user_by_keys(keys: {
  key: "value"
})
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**request:** `Schematic::Types::KeysRequestBody` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Companies::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.companies.<a href="/lib/schematic/companies/client.rb">lookup_user</a>() -> Schematic::Companies::Types::LookupUserResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.companies.lookup_user(keys: {
  keys: "keys"
})
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**keys:** `Internal::Types::Hash[String, String]` — Key/value pairs
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Companies::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## entitlements
<details><summary><code>client.entitlements.<a href="/lib/schematic/entitlements/client.rb">list_company_overrides</a>() -> Schematic::Entitlements::Types::ListCompanyOverridesResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.entitlements.list_company_overrides(
  company_id: "company_id",
  feature_id: "feature_id",
  without_expired: true,
  q: "q",
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**company_id:** `String` — Filter company overrides by a single company ID (starting with comp_)
    
</dd>
</dl>

<dl>
<dd>

**company_ids:** `String` — Filter company overrides by multiple company IDs (starting with comp_)
    
</dd>
</dl>

<dl>
<dd>

**feature_id:** `String` — Filter company overrides by a single feature ID (starting with feat_)
    
</dd>
</dl>

<dl>
<dd>

**feature_ids:** `String` — Filter company overrides by multiple feature IDs (starting with feat_)
    
</dd>
</dl>

<dl>
<dd>

**ids:** `String` — Filter company overrides by multiple company override IDs (starting with cmov_)
    
</dd>
</dl>

<dl>
<dd>

**without_expired:** `Internal::Types::Boolean` — Filter company overrides by whether they have not expired
    
</dd>
</dl>

<dl>
<dd>

**q:** `String` — Search for company overrides by feature or company name
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Entitlements::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.entitlements.<a href="/lib/schematic/entitlements/client.rb">create_company_override</a>(request) -> Schematic::Entitlements::Types::CreateCompanyOverrideResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.entitlements.create_company_override(
  company_id: "company_id",
  feature_id: "feature_id",
  value_type: "boolean"
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**company_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**credit_consumption_rate:** `Integer` 
    
</dd>
</dl>

<dl>
<dd>

**expiration_date:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**feature_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**metric_period:** `Schematic::Entitlements::Types::CreateCompanyOverrideRequestBodyMetricPeriod` 
    
</dd>
</dl>

<dl>
<dd>

**metric_period_month_reset:** `Schematic::Entitlements::Types::CreateCompanyOverrideRequestBodyMetricPeriodMonthReset` 
    
</dd>
</dl>

<dl>
<dd>

**note:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**value_bool:** `Internal::Types::Boolean` 
    
</dd>
</dl>

<dl>
<dd>

**value_credit_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**value_numeric:** `Integer` 
    
</dd>
</dl>

<dl>
<dd>

**value_trait_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**value_type:** `Schematic::Types::EntitlementValueType` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Entitlements::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.entitlements.<a href="/lib/schematic/entitlements/client.rb">get_company_override</a>(company_override_id) -> Schematic::Entitlements::Types::GetCompanyOverrideResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.entitlements.get_company_override(company_override_id: "company_override_id")
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**company_override_id:** `String` — company_override_id
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Entitlements::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.entitlements.<a href="/lib/schematic/entitlements/client.rb">update_company_override</a>(company_override_id, request) -> Schematic::Entitlements::Types::UpdateCompanyOverrideResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.entitlements.update_company_override(
  company_override_id: "company_override_id",
  value_type: "boolean"
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**company_override_id:** `String` — company_override_id
    
</dd>
</dl>

<dl>
<dd>

**credit_consumption_rate:** `Integer` 
    
</dd>
</dl>

<dl>
<dd>

**expiration_date:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**metric_period:** `Schematic::Entitlements::Types::UpdateCompanyOverrideRequestBodyMetricPeriod` 
    
</dd>
</dl>

<dl>
<dd>

**metric_period_month_reset:** `Schematic::Entitlements::Types::UpdateCompanyOverrideRequestBodyMetricPeriodMonthReset` 
    
</dd>
</dl>

<dl>
<dd>

**note:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**value_bool:** `Internal::Types::Boolean` 
    
</dd>
</dl>

<dl>
<dd>

**value_credit_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**value_numeric:** `Integer` 
    
</dd>
</dl>

<dl>
<dd>

**value_trait_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**value_type:** `Schematic::Types::EntitlementValueType` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Entitlements::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.entitlements.<a href="/lib/schematic/entitlements/client.rb">delete_company_override</a>(company_override_id) -> Schematic::Entitlements::Types::DeleteCompanyOverrideResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.entitlements.delete_company_override(company_override_id: "company_override_id")
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**company_override_id:** `String` — company_override_id
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Entitlements::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.entitlements.<a href="/lib/schematic/entitlements/client.rb">count_company_overrides</a>() -> Schematic::Entitlements::Types::CountCompanyOverridesResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.entitlements.count_company_overrides(
  company_id: "company_id",
  feature_id: "feature_id",
  without_expired: true,
  q: "q",
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**company_id:** `String` — Filter company overrides by a single company ID (starting with comp_)
    
</dd>
</dl>

<dl>
<dd>

**company_ids:** `String` — Filter company overrides by multiple company IDs (starting with comp_)
    
</dd>
</dl>

<dl>
<dd>

**feature_id:** `String` — Filter company overrides by a single feature ID (starting with feat_)
    
</dd>
</dl>

<dl>
<dd>

**feature_ids:** `String` — Filter company overrides by multiple feature IDs (starting with feat_)
    
</dd>
</dl>

<dl>
<dd>

**ids:** `String` — Filter company overrides by multiple company override IDs (starting with cmov_)
    
</dd>
</dl>

<dl>
<dd>

**without_expired:** `Internal::Types::Boolean` — Filter company overrides by whether they have not expired
    
</dd>
</dl>

<dl>
<dd>

**q:** `String` — Search for company overrides by feature or company name
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Entitlements::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.entitlements.<a href="/lib/schematic/entitlements/client.rb">list_feature_companies</a>() -> Schematic::Entitlements::Types::ListFeatureCompaniesResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.entitlements.list_feature_companies(
  feature_id: "feature_id",
  q: "q",
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**feature_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**q:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Entitlements::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.entitlements.<a href="/lib/schematic/entitlements/client.rb">count_feature_companies</a>() -> Schematic::Entitlements::Types::CountFeatureCompaniesResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.entitlements.count_feature_companies(
  feature_id: "feature_id",
  q: "q",
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**feature_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**q:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Entitlements::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.entitlements.<a href="/lib/schematic/entitlements/client.rb">list_feature_usage</a>() -> Schematic::Entitlements::Types::ListFeatureUsageResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.entitlements.list_feature_usage(
  company_id: "company_id",
  include_usage_aggregation: true,
  q: "q",
  without_negative_entitlements: true,
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**company_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**company_keys:** `Internal::Types::Hash[String, String]` 
    
</dd>
</dl>

<dl>
<dd>

**feature_ids:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**include_usage_aggregation:** `Internal::Types::Boolean` — Include time-bucketed usage aggregation (today, this week, this month, billing period) for credit-based entitlements. Defaults to false for performance.
    
</dd>
</dl>

<dl>
<dd>

**q:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**without_negative_entitlements:** `Internal::Types::Boolean` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Entitlements::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.entitlements.<a href="/lib/schematic/entitlements/client.rb">get_feature_usage_time_series</a>() -> Schematic::Entitlements::Types::GetFeatureUsageTimeSeriesResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.entitlements.get_feature_usage_time_series(
  company_id: "company_id",
  end_time: "2024-01-15T09:30:00Z",
  feature_id: "feature_id",
  granularity: "daily",
  start_time: "2024-01-15T09:30:00Z"
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**company_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**end_time:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**feature_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**granularity:** `Schematic::Types::TimeSeriesGranularity` 
    
</dd>
</dl>

<dl>
<dd>

**start_time:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Entitlements::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.entitlements.<a href="/lib/schematic/entitlements/client.rb">count_feature_usage</a>() -> Schematic::Entitlements::Types::CountFeatureUsageResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.entitlements.count_feature_usage(
  company_id: "company_id",
  include_usage_aggregation: true,
  q: "q",
  without_negative_entitlements: true,
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**company_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**company_keys:** `Internal::Types::Hash[String, String]` 
    
</dd>
</dl>

<dl>
<dd>

**feature_ids:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**include_usage_aggregation:** `Internal::Types::Boolean` — Include time-bucketed usage aggregation (today, this week, this month, billing period) for credit-based entitlements. Defaults to false for performance.
    
</dd>
</dl>

<dl>
<dd>

**q:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**without_negative_entitlements:** `Internal::Types::Boolean` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Entitlements::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.entitlements.<a href="/lib/schematic/entitlements/client.rb">list_feature_users</a>() -> Schematic::Entitlements::Types::ListFeatureUsersResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.entitlements.list_feature_users(
  feature_id: "feature_id",
  q: "q",
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**feature_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**q:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Entitlements::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.entitlements.<a href="/lib/schematic/entitlements/client.rb">count_feature_users</a>() -> Schematic::Entitlements::Types::CountFeatureUsersResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.entitlements.count_feature_users(
  feature_id: "feature_id",
  q: "q",
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**feature_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**q:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Entitlements::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.entitlements.<a href="/lib/schematic/entitlements/client.rb">list_plan_entitlements</a>() -> Schematic::Entitlements::Types::ListPlanEntitlementsResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.entitlements.list_plan_entitlements(
  feature_id: "feature_id",
  plan_id: "plan_id",
  plan_version_id: "plan_version_id",
  q: "q",
  with_metered_products: true,
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**feature_id:** `String` — Filter plan entitlements by a single feature ID (starting with feat_)
    
</dd>
</dl>

<dl>
<dd>

**feature_ids:** `String` — Filter plan entitlements by multiple feature IDs (starting with feat_)
    
</dd>
</dl>

<dl>
<dd>

**ids:** `String` — Filter plan entitlements by multiple plan entitlement IDs (starting with pltl_)
    
</dd>
</dl>

<dl>
<dd>

**plan_id:** `String` — Filter plan entitlements by a single plan ID (starting with plan_)
    
</dd>
</dl>

<dl>
<dd>

**plan_ids:** `String` — Filter plan entitlements by multiple plan IDs (starting with plan_)
    
</dd>
</dl>

<dl>
<dd>

**plan_version_id:** `String` — Filter plan entitlements by a single plan version ID (starting with plvr_)
    
</dd>
</dl>

<dl>
<dd>

**plan_version_ids:** `String` — Filter plan entitlements by multiple plan version IDs (starting with plvr_)
    
</dd>
</dl>

<dl>
<dd>

**q:** `String` — Search for plan entitlements by feature or company name
    
</dd>
</dl>

<dl>
<dd>

**with_metered_products:** `Internal::Types::Boolean` — Filter plan entitlements only with metered products
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Entitlements::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.entitlements.<a href="/lib/schematic/entitlements/client.rb">create_plan_entitlement</a>(request) -> Schematic::Entitlements::Types::CreatePlanEntitlementResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.entitlements.create_plan_entitlement(
  feature_id: "feature_id",
  plan_id: "plan_id",
  value_type: "boolean"
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**billing_product_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**billing_threshold:** `Integer` 
    
</dd>
</dl>

<dl>
<dd>

**credit_consumption_rate:** `Integer` 
    
</dd>
</dl>

<dl>
<dd>

**currency:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**feature_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**metric_period:** `Schematic::Entitlements::Types::CreatePlanEntitlementRequestBodyMetricPeriod` 
    
</dd>
</dl>

<dl>
<dd>

**metric_period_month_reset:** `Schematic::Entitlements::Types::CreatePlanEntitlementRequestBodyMetricPeriodMonthReset` 
    
</dd>
</dl>

<dl>
<dd>

**monthly_metered_price_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**monthly_price_tiers:** `Internal::Types::Array[Schematic::Types::CreatePriceTierRequestBody]` 
    
</dd>
</dl>

<dl>
<dd>

**monthly_unit_price:** `Integer` 
    
</dd>
</dl>

<dl>
<dd>

**monthly_unit_price_decimal:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**overage_billing_product_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**plan_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**plan_version_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**price_behavior:** `Schematic::Types::EntitlementPriceBehavior` 
    
</dd>
</dl>

<dl>
<dd>

**price_tiers:** `Internal::Types::Array[Schematic::Types::CreatePriceTierRequestBody]` — Use MonthlyPriceTiers or YearlyPriceTiers instead
    
</dd>
</dl>

<dl>
<dd>

**soft_limit:** `Integer` 
    
</dd>
</dl>

<dl>
<dd>

**tier_mode:** `Schematic::Types::BillingTiersMode` 
    
</dd>
</dl>

<dl>
<dd>

**value_bool:** `Internal::Types::Boolean` 
    
</dd>
</dl>

<dl>
<dd>

**value_credit_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**value_numeric:** `Integer` 
    
</dd>
</dl>

<dl>
<dd>

**value_trait_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**value_type:** `Schematic::Types::EntitlementValueType` 
    
</dd>
</dl>

<dl>
<dd>

**yearly_metered_price_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**yearly_price_tiers:** `Internal::Types::Array[Schematic::Types::CreatePriceTierRequestBody]` 
    
</dd>
</dl>

<dl>
<dd>

**yearly_unit_price:** `Integer` 
    
</dd>
</dl>

<dl>
<dd>

**yearly_unit_price_decimal:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Entitlements::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.entitlements.<a href="/lib/schematic/entitlements/client.rb">get_plan_entitlement</a>(plan_entitlement_id) -> Schematic::Entitlements::Types::GetPlanEntitlementResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.entitlements.get_plan_entitlement(plan_entitlement_id: "plan_entitlement_id")
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**plan_entitlement_id:** `String` — plan_entitlement_id
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Entitlements::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.entitlements.<a href="/lib/schematic/entitlements/client.rb">update_plan_entitlement</a>(plan_entitlement_id, request) -> Schematic::Entitlements::Types::UpdatePlanEntitlementResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.entitlements.update_plan_entitlement(
  plan_entitlement_id: "plan_entitlement_id",
  value_type: "boolean"
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**plan_entitlement_id:** `String` — plan_entitlement_id
    
</dd>
</dl>

<dl>
<dd>

**billing_product_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**billing_threshold:** `Integer` 
    
</dd>
</dl>

<dl>
<dd>

**credit_consumption_rate:** `Integer` 
    
</dd>
</dl>

<dl>
<dd>

**currency:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**metric_period:** `Schematic::Entitlements::Types::UpdatePlanEntitlementRequestBodyMetricPeriod` 
    
</dd>
</dl>

<dl>
<dd>

**metric_period_month_reset:** `Schematic::Entitlements::Types::UpdatePlanEntitlementRequestBodyMetricPeriodMonthReset` 
    
</dd>
</dl>

<dl>
<dd>

**monthly_metered_price_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**monthly_price_tiers:** `Internal::Types::Array[Schematic::Types::CreatePriceTierRequestBody]` 
    
</dd>
</dl>

<dl>
<dd>

**monthly_unit_price:** `Integer` 
    
</dd>
</dl>

<dl>
<dd>

**monthly_unit_price_decimal:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**overage_billing_product_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**price_behavior:** `Schematic::Types::EntitlementPriceBehavior` 
    
</dd>
</dl>

<dl>
<dd>

**price_tiers:** `Internal::Types::Array[Schematic::Types::CreatePriceTierRequestBody]` — Use MonthlyPriceTiers or YearlyPriceTiers instead
    
</dd>
</dl>

<dl>
<dd>

**soft_limit:** `Integer` 
    
</dd>
</dl>

<dl>
<dd>

**tier_mode:** `Schematic::Types::BillingTiersMode` 
    
</dd>
</dl>

<dl>
<dd>

**value_bool:** `Internal::Types::Boolean` 
    
</dd>
</dl>

<dl>
<dd>

**value_credit_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**value_numeric:** `Integer` 
    
</dd>
</dl>

<dl>
<dd>

**value_trait_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**value_type:** `Schematic::Types::EntitlementValueType` 
    
</dd>
</dl>

<dl>
<dd>

**yearly_metered_price_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**yearly_price_tiers:** `Internal::Types::Array[Schematic::Types::CreatePriceTierRequestBody]` 
    
</dd>
</dl>

<dl>
<dd>

**yearly_unit_price:** `Integer` 
    
</dd>
</dl>

<dl>
<dd>

**yearly_unit_price_decimal:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Entitlements::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.entitlements.<a href="/lib/schematic/entitlements/client.rb">delete_plan_entitlement</a>(plan_entitlement_id) -> Schematic::Entitlements::Types::DeletePlanEntitlementResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.entitlements.delete_plan_entitlement(plan_entitlement_id: "plan_entitlement_id")
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**plan_entitlement_id:** `String` — plan_entitlement_id
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Entitlements::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.entitlements.<a href="/lib/schematic/entitlements/client.rb">count_plan_entitlements</a>() -> Schematic::Entitlements::Types::CountPlanEntitlementsResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.entitlements.count_plan_entitlements(
  feature_id: "feature_id",
  plan_id: "plan_id",
  plan_version_id: "plan_version_id",
  q: "q",
  with_metered_products: true,
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**feature_id:** `String` — Filter plan entitlements by a single feature ID (starting with feat_)
    
</dd>
</dl>

<dl>
<dd>

**feature_ids:** `String` — Filter plan entitlements by multiple feature IDs (starting with feat_)
    
</dd>
</dl>

<dl>
<dd>

**ids:** `String` — Filter plan entitlements by multiple plan entitlement IDs (starting with pltl_)
    
</dd>
</dl>

<dl>
<dd>

**plan_id:** `String` — Filter plan entitlements by a single plan ID (starting with plan_)
    
</dd>
</dl>

<dl>
<dd>

**plan_ids:** `String` — Filter plan entitlements by multiple plan IDs (starting with plan_)
    
</dd>
</dl>

<dl>
<dd>

**plan_version_id:** `String` — Filter plan entitlements by a single plan version ID (starting with plvr_)
    
</dd>
</dl>

<dl>
<dd>

**plan_version_ids:** `String` — Filter plan entitlements by multiple plan version IDs (starting with plvr_)
    
</dd>
</dl>

<dl>
<dd>

**q:** `String` — Search for plan entitlements by feature or company name
    
</dd>
</dl>

<dl>
<dd>

**with_metered_products:** `Internal::Types::Boolean` — Filter plan entitlements only with metered products
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Entitlements::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.entitlements.<a href="/lib/schematic/entitlements/client.rb">duplicate_plan_entitlements</a>(request) -> Schematic::Entitlements::Types::DuplicatePlanEntitlementsResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.entitlements.duplicate_plan_entitlements(
  source_plan_id: "source_plan_id",
  target_plan_id: "target_plan_id"
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**source_plan_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**target_plan_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Entitlements::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.entitlements.<a href="/lib/schematic/entitlements/client.rb">get_feature_usage_by_company</a>() -> Schematic::Entitlements::Types::GetFeatureUsageByCompanyResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.entitlements.get_feature_usage_by_company(keys: {
  keys: "keys"
})
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**keys:** `Internal::Types::Hash[String, String]` — Key/value pairs
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Entitlements::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## plans
<details><summary><code>client.plans.<a href="/lib/schematic/plans/client.rb">update_company_plans</a>(company_plan_id, request) -> Schematic::Plans::Types::UpdateCompanyPlansResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.plans.update_company_plans(
  company_plan_id: "company_plan_id",
  add_on_ids: ["add_on_ids"]
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**company_plan_id:** `String` — company_plan_id
    
</dd>
</dl>

<dl>
<dd>

**add_on_ids:** `Internal::Types::Array[String]` 
    
</dd>
</dl>

<dl>
<dd>

**base_plan_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Plans::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.plans.<a href="/lib/schematic/plans/client.rb">list_plans</a>() -> Schematic::Plans::Types::ListPlansResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.plans.list_plans(
  company_id: "company_id",
  for_fallback_plan: true,
  for_initial_plan: true,
  for_trial_expiry_plan: true,
  has_product_id: true,
  include_draft_versions: true,
  plan_type: "plan",
  q: "q",
  without_entitlement_for: "without_entitlement_for",
  without_paid_product_id: true,
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**company_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**for_fallback_plan:** `Internal::Types::Boolean` — Filter for plans valid as fallback plans (not linked to billing)
    
</dd>
</dl>

<dl>
<dd>

**for_initial_plan:** `Internal::Types::Boolean` — Filter for plans valid as initial plans (not linked to billing, free, or auto-cancelling trial)
    
</dd>
</dl>

<dl>
<dd>

**for_trial_expiry_plan:** `Internal::Types::Boolean` — Filter for plans valid as trial expiry plans (not linked to billing or free)
    
</dd>
</dl>

<dl>
<dd>

**has_product_id:** `Internal::Types::Boolean` — Filter out plans that do not have a billing product ID
    
</dd>
</dl>

<dl>
<dd>

**ids:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**include_draft_versions:** `Internal::Types::Boolean` — Include billing settings from draft versions for plans which have draft version
    
</dd>
</dl>

<dl>
<dd>

**plan_type:** `Schematic::Types::PlanType` — Filter by plan type
    
</dd>
</dl>

<dl>
<dd>

**q:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**without_entitlement_for:** `String` — Filter out plans that already have a plan entitlement for the specified feature ID
    
</dd>
</dl>

<dl>
<dd>

**without_paid_product_id:** `Internal::Types::Boolean` — Filter out plans that have a paid billing product ID
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Plans::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.plans.<a href="/lib/schematic/plans/client.rb">create_plan</a>(request) -> Schematic::Plans::Types::CreatePlanResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.plans.create_plan(
  description: "description",
  name: "name",
  plan_type: "plan"
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**request:** `Schematic::Types::CreatePlanRequestBody` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Plans::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.plans.<a href="/lib/schematic/plans/client.rb">get_plan</a>(plan_id) -> Schematic::Plans::Types::GetPlanResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.plans.get_plan(
  plan_id: "plan_id",
  plan_version_id: "plan_version_id"
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**plan_id:** `String` — plan_id
    
</dd>
</dl>

<dl>
<dd>

**plan_version_id:** `String` — Fetch billing settings for a specific plan version
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Plans::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.plans.<a href="/lib/schematic/plans/client.rb">update_plan</a>(plan_id, request) -> Schematic::Plans::Types::UpdatePlanResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.plans.update_plan(
  plan_id: "plan_id",
  name: "name"
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**plan_id:** `String` — plan_id
    
</dd>
</dl>

<dl>
<dd>

**request:** `Schematic::Types::UpdatePlanRequestBody` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Plans::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.plans.<a href="/lib/schematic/plans/client.rb">delete_plan</a>(plan_id) -> Schematic::Plans::Types::DeletePlanResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.plans.delete_plan(plan_id: "plan_id")
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**plan_id:** `String` — plan_id
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Plans::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.plans.<a href="/lib/schematic/plans/client.rb">upsert_billing_product_plan</a>(plan_id, request) -> Schematic::Plans::Types::UpsertBillingProductPlanResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.plans.upsert_billing_product_plan(
  plan_id: "plan_id",
  charge_type: "free",
  is_trialable: true
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**plan_id:** `String` — plan_id
    
</dd>
</dl>

<dl>
<dd>

**request:** `Schematic::Types::UpsertBillingProductRequestBody` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Plans::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.plans.<a href="/lib/schematic/plans/client.rb">count_plans</a>() -> Schematic::Plans::Types::CountPlansResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.plans.count_plans(
  company_id: "company_id",
  for_fallback_plan: true,
  for_initial_plan: true,
  for_trial_expiry_plan: true,
  has_product_id: true,
  include_draft_versions: true,
  plan_type: "plan",
  q: "q",
  without_entitlement_for: "without_entitlement_for",
  without_paid_product_id: true,
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**company_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**for_fallback_plan:** `Internal::Types::Boolean` — Filter for plans valid as fallback plans (not linked to billing)
    
</dd>
</dl>

<dl>
<dd>

**for_initial_plan:** `Internal::Types::Boolean` — Filter for plans valid as initial plans (not linked to billing, free, or auto-cancelling trial)
    
</dd>
</dl>

<dl>
<dd>

**for_trial_expiry_plan:** `Internal::Types::Boolean` — Filter for plans valid as trial expiry plans (not linked to billing or free)
    
</dd>
</dl>

<dl>
<dd>

**has_product_id:** `Internal::Types::Boolean` — Filter out plans that do not have a billing product ID
    
</dd>
</dl>

<dl>
<dd>

**ids:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**include_draft_versions:** `Internal::Types::Boolean` — Include billing settings from draft versions for plans which have draft version
    
</dd>
</dl>

<dl>
<dd>

**plan_type:** `Schematic::Types::PlanType` — Filter by plan type
    
</dd>
</dl>

<dl>
<dd>

**q:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**without_entitlement_for:** `String` — Filter out plans that already have a plan entitlement for the specified feature ID
    
</dd>
</dl>

<dl>
<dd>

**without_paid_product_id:** `Internal::Types::Boolean` — Filter out plans that have a paid billing product ID
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Plans::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.plans.<a href="/lib/schematic/plans/client.rb">list_plan_issues</a>() -> Schematic::Plans::Types::ListPlanIssuesResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.plans.list_plan_issues(
  plan_id: "plan_id",
  plan_version_id: "plan_version_id"
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**plan_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**plan_version_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Plans::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.plans.<a href="/lib/schematic/plans/client.rb">delete_plan_version</a>(plan_id) -> Schematic::Plans::Types::DeletePlanVersionResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.plans.delete_plan_version(
  plan_id: "plan_id",
  promote_archived_version: true
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**plan_id:** `String` — plan_id
    
</dd>
</dl>

<dl>
<dd>

**promote_archived_version:** `Internal::Types::Boolean` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Plans::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.plans.<a href="/lib/schematic/plans/client.rb">publish_plan_version</a>(plan_id, request) -> Schematic::Plans::Types::PublishPlanVersionResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.plans.publish_plan_version(
  plan_id: "plan_id",
  excluded_company_ids: ["excluded_company_ids"],
  migration_strategy: "immediate"
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**plan_id:** `String` — plan_id
    
</dd>
</dl>

<dl>
<dd>

**excluded_company_ids:** `Internal::Types::Array[String]` 
    
</dd>
</dl>

<dl>
<dd>

**migration_strategy:** `Schematic::Types::PlanVersionMigrationStrategy` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Plans::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## components
<details><summary><code>client.components.<a href="/lib/schematic/components/client.rb">list_components</a>() -> Schematic::Components::Types::ListComponentsResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.components.list_components(
  q: "q",
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**q:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Components::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.components.<a href="/lib/schematic/components/client.rb">create_component</a>(request) -> Schematic::Components::Types::CreateComponentResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.components.create_component(
  entity_type: "billing",
  name: "name"
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**ast:** `Internal::Types::Hash[String, Integer]` 
    
</dd>
</dl>

<dl>
<dd>

**entity_type:** `Schematic::Types::ComponentEntityType` 
    
</dd>
</dl>

<dl>
<dd>

**name:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Components::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.components.<a href="/lib/schematic/components/client.rb">get_component</a>(component_id) -> Schematic::Components::Types::GetComponentResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.components.get_component(component_id: "component_id")
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**component_id:** `String` — component_id
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Components::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.components.<a href="/lib/schematic/components/client.rb">update_component</a>(component_id, request) -> Schematic::Components::Types::UpdateComponentResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.components.update_component(component_id: "component_id")
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**component_id:** `String` — component_id
    
</dd>
</dl>

<dl>
<dd>

**ast:** `Internal::Types::Hash[String, Integer]` 
    
</dd>
</dl>

<dl>
<dd>

**entity_type:** `Schematic::Types::ComponentEntityType` 
    
</dd>
</dl>

<dl>
<dd>

**name:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**state:** `Schematic::Types::ComponentState` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Components::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.components.<a href="/lib/schematic/components/client.rb">delete_component</a>(component_id) -> Schematic::Components::Types::DeleteComponentResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.components.delete_component(component_id: "component_id")
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**component_id:** `String` — component_id
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Components::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.components.<a href="/lib/schematic/components/client.rb">count_components</a>() -> Schematic::Components::Types::CountComponentsResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.components.count_components(
  q: "q",
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**q:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Components::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.components.<a href="/lib/schematic/components/client.rb">preview_component_data</a>() -> Schematic::Components::Types::PreviewComponentDataResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.components.preview_component_data(
  company_id: "company_id",
  component_id: "component_id"
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**company_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**component_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Components::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## dataexports
<details><summary><code>client.dataexports.<a href="/lib/schematic/dataexports/client.rb">create_data_export</a>(request) -> Schematic::Dataexports::Types::CreateDataExportResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.dataexports.create_data_export(
  export_type: "company-feature-usage",
  metadata: "metadata",
  output_file_type: "csv"
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**export_type:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**metadata:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**output_file_type:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Dataexports::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.dataexports.<a href="/lib/schematic/dataexports/client.rb">get_data_export_artifact</a>(data_export_id) -> String</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.dataexports.get_data_export_artifact(data_export_id: "data_export_id")
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**data_export_id:** `String` — data_export_id
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Dataexports::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## events
<details><summary><code>client.events.<a href="/lib/schematic/events/client.rb">create_event_batch</a>(request) -> Schematic::Events::Types::CreateEventBatchResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.events.create_event_batch(events: [{
  event_type: "flag_check"
}])
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**events:** `Internal::Types::Array[Schematic::Types::CreateEventRequestBody]` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Events::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.events.<a href="/lib/schematic/events/client.rb">get_event_summaries</a>() -> Schematic::Events::Types::GetEventSummariesResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.events.get_event_summaries(
  q: "q",
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**q:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**event_subtypes:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Events::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.events.<a href="/lib/schematic/events/client.rb">list_events</a>() -> Schematic::Events::Types::ListEventsResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.events.list_events(
  company_id: "company_id",
  event_subtype: "event_subtype",
  flag_id: "flag_id",
  user_id: "user_id",
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**company_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**event_subtype:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**event_types:** `Schematic::Types::EventType` 
    
</dd>
</dl>

<dl>
<dd>

**flag_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**user_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Events::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.events.<a href="/lib/schematic/events/client.rb">create_event</a>(request) -> Schematic::Events::Types::CreateEventResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.events.create_event(event_type: "flag_check")
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**request:** `Schematic::Types::CreateEventRequestBody` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Events::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.events.<a href="/lib/schematic/events/client.rb">get_event</a>(event_id) -> Schematic::Events::Types::GetEventResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.events.get_event(event_id: "event_id")
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**event_id:** `String` — event_id
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Events::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.events.<a href="/lib/schematic/events/client.rb">get_segment_integration_status</a>() -> Schematic::Events::Types::GetSegmentIntegrationStatusResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.events.get_segment_integration_status
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**request_options:** `Schematic::Events::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## features
<details><summary><code>client.features.<a href="/lib/schematic/features/client.rb">list_features</a>() -> Schematic::Features::Types::ListFeaturesResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.features.list_features(
  q: "q",
  without_company_override_for: "without_company_override_for",
  plan_version_id: "plan_version_id",
  without_plan_entitlement_for: "without_plan_entitlement_for",
  boolean_require_event: true,
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**ids:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**q:** `String` — Search by feature name or ID
    
</dd>
</dl>

<dl>
<dd>

**without_company_override_for:** `String` — Filter out features that already have a company override for the specified company ID
    
</dd>
</dl>

<dl>
<dd>

**plan_version_id:** `String` — Filter by plan version ID when used with without_plan_entitlement_for; if not provided, the latest published version is used
    
</dd>
</dl>

<dl>
<dd>

**without_plan_entitlement_for:** `String` — Filter out features that already have a plan entitlement for the specified plan ID
    
</dd>
</dl>

<dl>
<dd>

**feature_type:** `Schematic::Types::FeatureType` — Filter by one or more feature types (boolean, event, trait)
    
</dd>
</dl>

<dl>
<dd>

**boolean_require_event:** `Internal::Types::Boolean` — Only return boolean features if there is an associated event. Automatically includes boolean in the feature types filter.
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Features::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.features.<a href="/lib/schematic/features/client.rb">create_feature</a>(request) -> Schematic::Features::Types::CreateFeatureResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.features.create_feature(
  description: "description",
  feature_type: "boolean",
  name: "name"
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**description:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**event_subtype:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**feature_type:** `Schematic::Types::FeatureType` 
    
</dd>
</dl>

<dl>
<dd>

**flag:** `Schematic::Types::CreateOrUpdateFlagRequestBody` 
    
</dd>
</dl>

<dl>
<dd>

**icon:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**lifecycle_phase:** `Schematic::Types::FeatureLifecyclePhase` 
    
</dd>
</dl>

<dl>
<dd>

**maintainer_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**name:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**plural_name:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**singular_name:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**trait_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Features::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.features.<a href="/lib/schematic/features/client.rb">get_feature</a>(feature_id) -> Schematic::Features::Types::GetFeatureResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.features.get_feature(feature_id: "feature_id")
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**feature_id:** `String` — feature_id
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Features::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.features.<a href="/lib/schematic/features/client.rb">update_feature</a>(feature_id, request) -> Schematic::Features::Types::UpdateFeatureResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.features.update_feature(feature_id: "feature_id")
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**feature_id:** `String` — feature_id
    
</dd>
</dl>

<dl>
<dd>

**description:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**event_subtype:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**feature_type:** `Schematic::Types::FeatureType` 
    
</dd>
</dl>

<dl>
<dd>

**flag:** `Schematic::Types::CreateOrUpdateFlagRequestBody` 
    
</dd>
</dl>

<dl>
<dd>

**icon:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**lifecycle_phase:** `Schematic::Types::FeatureLifecyclePhase` 
    
</dd>
</dl>

<dl>
<dd>

**maintainer_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**name:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**plural_name:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**singular_name:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**trait_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Features::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.features.<a href="/lib/schematic/features/client.rb">delete_feature</a>(feature_id) -> Schematic::Features::Types::DeleteFeatureResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.features.delete_feature(feature_id: "feature_id")
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**feature_id:** `String` — feature_id
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Features::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.features.<a href="/lib/schematic/features/client.rb">count_features</a>() -> Schematic::Features::Types::CountFeaturesResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.features.count_features(
  q: "q",
  without_company_override_for: "without_company_override_for",
  plan_version_id: "plan_version_id",
  without_plan_entitlement_for: "without_plan_entitlement_for",
  boolean_require_event: true,
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**ids:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**q:** `String` — Search by feature name or ID
    
</dd>
</dl>

<dl>
<dd>

**without_company_override_for:** `String` — Filter out features that already have a company override for the specified company ID
    
</dd>
</dl>

<dl>
<dd>

**plan_version_id:** `String` — Filter by plan version ID when used with without_plan_entitlement_for; if not provided, the latest published version is used
    
</dd>
</dl>

<dl>
<dd>

**without_plan_entitlement_for:** `String` — Filter out features that already have a plan entitlement for the specified plan ID
    
</dd>
</dl>

<dl>
<dd>

**feature_type:** `Schematic::Types::FeatureType` — Filter by one or more feature types (boolean, event, trait)
    
</dd>
</dl>

<dl>
<dd>

**boolean_require_event:** `Internal::Types::Boolean` — Only return boolean features if there is an associated event. Automatically includes boolean in the feature types filter.
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Features::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.features.<a href="/lib/schematic/features/client.rb">list_flags</a>() -> Schematic::Features::Types::ListFlagsResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.features.list_flags(
  feature_id: "feature_id",
  q: "q",
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**feature_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**ids:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**q:** `String` — Search by flag name, key, or ID
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Features::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.features.<a href="/lib/schematic/features/client.rb">create_flag</a>(request) -> Schematic::Features::Types::CreateFlagResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.features.create_flag(
  default_value: true,
  description: "description",
  flag_type: "boolean",
  key: "key",
  name: "name"
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**request:** `Schematic::Types::CreateFlagRequestBody` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Features::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.features.<a href="/lib/schematic/features/client.rb">get_flag</a>(flag_id) -> Schematic::Features::Types::GetFlagResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.features.get_flag(flag_id: "flag_id")
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**flag_id:** `String` — flag_id
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Features::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.features.<a href="/lib/schematic/features/client.rb">update_flag</a>(flag_id, request) -> Schematic::Features::Types::UpdateFlagResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.features.update_flag(
  flag_id: "flag_id",
  default_value: true,
  description: "description",
  flag_type: "boolean",
  key: "key",
  name: "name"
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**flag_id:** `String` — flag_id
    
</dd>
</dl>

<dl>
<dd>

**request:** `Schematic::Types::CreateFlagRequestBody` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Features::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.features.<a href="/lib/schematic/features/client.rb">delete_flag</a>(flag_id) -> Schematic::Features::Types::DeleteFlagResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.features.delete_flag(flag_id: "flag_id")
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**flag_id:** `String` — flag_id
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Features::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.features.<a href="/lib/schematic/features/client.rb">update_flag_rules</a>(flag_id, request) -> Schematic::Features::Types::UpdateFlagRulesResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.features.update_flag_rules(
  flag_id: "flag_id",
  rules: [{
    condition_groups: [{
      conditions: [{
        condition_type: "company",
        operator: "eq",
        resource_ids: ["resource_ids"]
      }]
    }],
    conditions: [{
      condition_type: "company",
      operator: "eq",
      resource_ids: ["resource_ids"]
    }],
    name: "name",
    priority: 1000000,
    value: true
  }]
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**flag_id:** `String` — flag_id
    
</dd>
</dl>

<dl>
<dd>

**rules:** `Internal::Types::Array[Schematic::Types::CreateOrUpdateRuleRequestBody]` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Features::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.features.<a href="/lib/schematic/features/client.rb">check_flag</a>(key, request) -> Schematic::Features::Types::CheckFlagResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.features.check_flag(key: "key")
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**key:** `String` — key
    
</dd>
</dl>

<dl>
<dd>

**request:** `Schematic::Types::CheckFlagRequestBody` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Features::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.features.<a href="/lib/schematic/features/client.rb">check_flags</a>(request) -> Schematic::Features::Types::CheckFlagsResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.features.check_flags
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**request:** `Schematic::Types::CheckFlagRequestBody` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Features::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.features.<a href="/lib/schematic/features/client.rb">check_flags_bulk</a>(request) -> Schematic::Features::Types::CheckFlagsBulkResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.features.check_flags_bulk(contexts: [{}])
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**contexts:** `Internal::Types::Array[Schematic::Types::CheckFlagRequestBody]` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Features::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.features.<a href="/lib/schematic/features/client.rb">count_flags</a>() -> Schematic::Features::Types::CountFlagsResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.features.count_flags(
  feature_id: "feature_id",
  q: "q",
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**feature_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**ids:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**q:** `String` — Search by flag name, key, or ID
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Features::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## planbundle
<details><summary><code>client.planbundle.<a href="/lib/schematic/planbundle/client.rb">create_plan_bundle</a>(request) -> Schematic::Planbundle::Types::CreatePlanBundleResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.planbundle.create_plan_bundle(entitlements: [{
  action: "create"
}])
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**billing_product:** `Schematic::Types::UpsertBillingProductRequestBody` 
    
</dd>
</dl>

<dl>
<dd>

**credit_grants:** `Internal::Types::Array[Schematic::Types::PlanBundleCreditGrantRequestBody]` 
    
</dd>
</dl>

<dl>
<dd>

**entitlements:** `Internal::Types::Array[Schematic::Types::PlanBundleEntitlementRequestBody]` 
    
</dd>
</dl>

<dl>
<dd>

**plan:** `Schematic::Types::CreatePlanRequestBody` 
    
</dd>
</dl>

<dl>
<dd>

**traits:** `Internal::Types::Array[Schematic::Types::UpdatePlanTraitTraitRequestBody]` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Planbundle::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.planbundle.<a href="/lib/schematic/planbundle/client.rb">update_plan_bundle</a>(plan_bundle_id, request) -> Schematic::Planbundle::Types::UpdatePlanBundleResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.planbundle.update_plan_bundle(
  plan_bundle_id: "plan_bundle_id",
  entitlements: [{
    action: "create"
  }]
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**plan_bundle_id:** `String` — plan_bundle_id
    
</dd>
</dl>

<dl>
<dd>

**billing_product:** `Schematic::Types::UpsertBillingProductRequestBody` 
    
</dd>
</dl>

<dl>
<dd>

**credit_grants:** `Internal::Types::Array[Schematic::Types::PlanBundleCreditGrantRequestBody]` 
    
</dd>
</dl>

<dl>
<dd>

**entitlements:** `Internal::Types::Array[Schematic::Types::PlanBundleEntitlementRequestBody]` 
    
</dd>
</dl>

<dl>
<dd>

**plan:** `Schematic::Types::UpdatePlanRequestBody` 
    
</dd>
</dl>

<dl>
<dd>

**plan_version_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**traits:** `Internal::Types::Array[Schematic::Types::UpdatePlanTraitTraitRequestBody]` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Planbundle::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## plangroups
<details><summary><code>client.plangroups.<a href="/lib/schematic/plangroups/client.rb">get_plan_group</a>() -> Schematic::Plangroups::Types::GetPlanGroupResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.plangroups.get_plan_group(include_company_counts: true)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**include_company_counts:** `Internal::Types::Boolean` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Plangroups::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.plangroups.<a href="/lib/schematic/plangroups/client.rb">create_plan_group</a>(request) -> Schematic::Plangroups::Types::CreatePlanGroupResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.plangroups.create_plan_group(
  add_on_ids: ["add_on_ids"],
  checkout_collect_address: true,
  checkout_collect_email: true,
  checkout_collect_phone: true,
  enable_tax_collection: true,
  ordered_add_ons: [{
    plan_id: "plan_id"
  }],
  ordered_bundle_list: [{
    bundle_id: "bundleId"
  }],
  ordered_plans: [{
    plan_id: "plan_id"
  }],
  prevent_downgrades_when_over_limit: true,
  prevent_self_service_downgrade: true,
  proration_behavior: "create_prorations",
  show_as_monthly_prices: true,
  show_credits: true,
  show_feature_description: true,
  show_hard_limit: true,
  show_period_toggle: true,
  show_zero_price_as_free: true,
  sync_customer_billing_details: true
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**add_on_compatibilities:** `Internal::Types::Array[Schematic::Types::CompatiblePlans]` 
    
</dd>
</dl>

<dl>
<dd>

**add_on_ids:** `Internal::Types::Array[String]` — Use OrderedAddOns instead
    
</dd>
</dl>

<dl>
<dd>

**checkout_collect_address:** `Internal::Types::Boolean` 
    
</dd>
</dl>

<dl>
<dd>

**checkout_collect_email:** `Internal::Types::Boolean` 
    
</dd>
</dl>

<dl>
<dd>

**checkout_collect_phone:** `Internal::Types::Boolean` 
    
</dd>
</dl>

<dl>
<dd>

**custom_plan_config:** `Schematic::Types::CustomPlanConfig` 
    
</dd>
</dl>

<dl>
<dd>

**custom_plan_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**enable_tax_collection:** `Internal::Types::Boolean` 
    
</dd>
</dl>

<dl>
<dd>

**fallback_plan_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**initial_plan_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**initial_plan_price_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**ordered_add_ons:** `Internal::Types::Array[Schematic::Types::OrderedPlansInGroup]` 
    
</dd>
</dl>

<dl>
<dd>

**ordered_bundle_list:** `Internal::Types::Array[Schematic::Types::PlanGroupBundleOrder]` 
    
</dd>
</dl>

<dl>
<dd>

**ordered_plans:** `Internal::Types::Array[Schematic::Types::OrderedPlansInGroup]` 
    
</dd>
</dl>

<dl>
<dd>

**prevent_downgrades_when_over_limit:** `Internal::Types::Boolean` 
    
</dd>
</dl>

<dl>
<dd>

**prevent_self_service_downgrade:** `Internal::Types::Boolean` 
    
</dd>
</dl>

<dl>
<dd>

**prevent_self_service_downgrade_button_text:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**prevent_self_service_downgrade_url:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**proration_behavior:** `Schematic::Types::ProrationBehavior` 
    
</dd>
</dl>

<dl>
<dd>

**scheduled_downgrade_behavior:** `Schematic::Types::ScheduledDowngradeConfigBehavior` 
    
</dd>
</dl>

<dl>
<dd>

**scheduled_downgrade_prevent_when_over_limit:** `Internal::Types::Boolean` 
    
</dd>
</dl>

<dl>
<dd>

**show_as_monthly_prices:** `Internal::Types::Boolean` 
    
</dd>
</dl>

<dl>
<dd>

**show_credits:** `Internal::Types::Boolean` 
    
</dd>
</dl>

<dl>
<dd>

**show_feature_description:** `Internal::Types::Boolean` 
    
</dd>
</dl>

<dl>
<dd>

**show_hard_limit:** `Internal::Types::Boolean` 
    
</dd>
</dl>

<dl>
<dd>

**show_period_toggle:** `Internal::Types::Boolean` 
    
</dd>
</dl>

<dl>
<dd>

**show_zero_price_as_free:** `Internal::Types::Boolean` 
    
</dd>
</dl>

<dl>
<dd>

**sync_customer_billing_details:** `Internal::Types::Boolean` 
    
</dd>
</dl>

<dl>
<dd>

**trial_days:** `Integer` 
    
</dd>
</dl>

<dl>
<dd>

**trial_expiry_plan_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**trial_expiry_plan_price_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**trial_payment_method_required:** `Internal::Types::Boolean` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Plangroups::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.plangroups.<a href="/lib/schematic/plangroups/client.rb">update_plan_group</a>(plan_group_id, request) -> Schematic::Plangroups::Types::UpdatePlanGroupResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.plangroups.update_plan_group(
  plan_group_id: "plan_group_id",
  add_on_ids: ["add_on_ids"],
  checkout_collect_address: true,
  checkout_collect_email: true,
  checkout_collect_phone: true,
  enable_tax_collection: true,
  ordered_add_ons: [{
    plan_id: "plan_id"
  }],
  ordered_bundle_list: [{
    bundle_id: "bundleId"
  }],
  ordered_plans: [{
    plan_id: "plan_id"
  }],
  prevent_downgrades_when_over_limit: true,
  prevent_self_service_downgrade: true,
  proration_behavior: "create_prorations",
  show_as_monthly_prices: true,
  show_credits: true,
  show_feature_description: true,
  show_hard_limit: true,
  show_period_toggle: true,
  show_zero_price_as_free: true,
  sync_customer_billing_details: true
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**plan_group_id:** `String` — plan_group_id
    
</dd>
</dl>

<dl>
<dd>

**add_on_compatibilities:** `Internal::Types::Array[Schematic::Types::CompatiblePlans]` 
    
</dd>
</dl>

<dl>
<dd>

**add_on_ids:** `Internal::Types::Array[String]` — Use OrderedAddOns instead
    
</dd>
</dl>

<dl>
<dd>

**checkout_collect_address:** `Internal::Types::Boolean` 
    
</dd>
</dl>

<dl>
<dd>

**checkout_collect_email:** `Internal::Types::Boolean` 
    
</dd>
</dl>

<dl>
<dd>

**checkout_collect_phone:** `Internal::Types::Boolean` 
    
</dd>
</dl>

<dl>
<dd>

**custom_plan_config:** `Schematic::Types::CustomPlanConfig` 
    
</dd>
</dl>

<dl>
<dd>

**custom_plan_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**enable_tax_collection:** `Internal::Types::Boolean` 
    
</dd>
</dl>

<dl>
<dd>

**fallback_plan_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**initial_plan_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**initial_plan_price_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**ordered_add_ons:** `Internal::Types::Array[Schematic::Types::OrderedPlansInGroup]` 
    
</dd>
</dl>

<dl>
<dd>

**ordered_bundle_list:** `Internal::Types::Array[Schematic::Types::PlanGroupBundleOrder]` 
    
</dd>
</dl>

<dl>
<dd>

**ordered_plans:** `Internal::Types::Array[Schematic::Types::OrderedPlansInGroup]` 
    
</dd>
</dl>

<dl>
<dd>

**prevent_downgrades_when_over_limit:** `Internal::Types::Boolean` 
    
</dd>
</dl>

<dl>
<dd>

**prevent_self_service_downgrade:** `Internal::Types::Boolean` 
    
</dd>
</dl>

<dl>
<dd>

**prevent_self_service_downgrade_button_text:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**prevent_self_service_downgrade_url:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**proration_behavior:** `Schematic::Types::ProrationBehavior` 
    
</dd>
</dl>

<dl>
<dd>

**scheduled_downgrade_behavior:** `Schematic::Types::ScheduledDowngradeConfigBehavior` 
    
</dd>
</dl>

<dl>
<dd>

**scheduled_downgrade_prevent_when_over_limit:** `Internal::Types::Boolean` 
    
</dd>
</dl>

<dl>
<dd>

**show_as_monthly_prices:** `Internal::Types::Boolean` 
    
</dd>
</dl>

<dl>
<dd>

**show_credits:** `Internal::Types::Boolean` 
    
</dd>
</dl>

<dl>
<dd>

**show_feature_description:** `Internal::Types::Boolean` 
    
</dd>
</dl>

<dl>
<dd>

**show_hard_limit:** `Internal::Types::Boolean` 
    
</dd>
</dl>

<dl>
<dd>

**show_period_toggle:** `Internal::Types::Boolean` 
    
</dd>
</dl>

<dl>
<dd>

**show_zero_price_as_free:** `Internal::Types::Boolean` 
    
</dd>
</dl>

<dl>
<dd>

**sync_customer_billing_details:** `Internal::Types::Boolean` 
    
</dd>
</dl>

<dl>
<dd>

**trial_days:** `Integer` 
    
</dd>
</dl>

<dl>
<dd>

**trial_expiry_plan_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**trial_expiry_plan_price_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**trial_payment_method_required:** `Internal::Types::Boolean` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Plangroups::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## planmigrations
<details><summary><code>client.planmigrations.<a href="/lib/schematic/planmigrations/client.rb">list_company_migrations</a>() -> Schematic::Planmigrations::Types::ListCompanyMigrationsResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.planmigrations.list_company_migrations(
  migration_id: "migration_id",
  q: "q",
  status: "completed",
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**migration_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**q:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**status:** `Schematic::Types::PlanVersionCompanyMigrationStatus` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Planmigrations::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.planmigrations.<a href="/lib/schematic/planmigrations/client.rb">count_company_migrations</a>() -> Schematic::Planmigrations::Types::CountCompanyMigrationsResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.planmigrations.count_company_migrations(
  migration_id: "migration_id",
  q: "q",
  status: "completed",
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**migration_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**q:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**status:** `Schematic::Types::PlanVersionCompanyMigrationStatus` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Planmigrations::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.planmigrations.<a href="/lib/schematic/planmigrations/client.rb">list_migrations</a>() -> Schematic::Planmigrations::Types::ListMigrationsResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.planmigrations.list_migrations(
  plan_version_id: "plan_version_id",
  status: "completed",
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**plan_version_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**status:** `Schematic::Types::PlanVersionMigrationStatus` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Planmigrations::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.planmigrations.<a href="/lib/schematic/planmigrations/client.rb">get_migration</a>(plan_version_migration_id) -> Schematic::Planmigrations::Types::GetMigrationResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.planmigrations.get_migration(plan_version_migration_id: "plan_version_migration_id")
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**plan_version_migration_id:** `String` — plan_version_migration_id
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Planmigrations::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.planmigrations.<a href="/lib/schematic/planmigrations/client.rb">count_migrations</a>() -> Schematic::Planmigrations::Types::CountMigrationsResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.planmigrations.count_migrations(
  plan_version_id: "plan_version_id",
  status: "completed",
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**plan_version_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**status:** `Schematic::Types::PlanVersionMigrationStatus` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Planmigrations::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## componentspublic
<details><summary><code>client.componentspublic.<a href="/lib/schematic/componentspublic/client.rb">get_public_plans</a>() -> Schematic::Componentspublic::Types::GetPublicPlansResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.componentspublic.get_public_plans
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**request_options:** `Schematic::Componentspublic::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## scheduledcheckout
<details><summary><code>client.scheduledcheckout.<a href="/lib/schematic/scheduledcheckout/client.rb">list_scheduled_checkouts</a>() -> Schematic::Scheduledcheckout::Types::ListScheduledCheckoutsResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.scheduledcheckout.list_scheduled_checkouts(
  company_id: "company_id",
  status: "cancelled",
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**company_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**status:** `Schematic::Types::ScheduledCheckoutStatus` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Scheduledcheckout::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.scheduledcheckout.<a href="/lib/schematic/scheduledcheckout/client.rb">create_scheduled_checkout</a>(request) -> Schematic::Scheduledcheckout::Types::CreateScheduledCheckoutResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.scheduledcheckout.create_scheduled_checkout(
  company_id: "company_id",
  execute_after: "2024-01-15T09:30:00Z",
  from_plan_id: "from_plan_id",
  to_plan_id: "to_plan_id"
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**company_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**execute_after:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**from_plan_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**to_plan_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Scheduledcheckout::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.scheduledcheckout.<a href="/lib/schematic/scheduledcheckout/client.rb">get_scheduled_checkout</a>(scheduled_checkout_id) -> Schematic::Scheduledcheckout::Types::GetScheduledCheckoutResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.scheduledcheckout.get_scheduled_checkout(scheduled_checkout_id: "scheduled_checkout_id")
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**scheduled_checkout_id:** `String` — scheduled_checkout_id
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Scheduledcheckout::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.scheduledcheckout.<a href="/lib/schematic/scheduledcheckout/client.rb">update_scheduled_checkout</a>(scheduled_checkout_id, request) -> Schematic::Scheduledcheckout::Types::UpdateScheduledCheckoutResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.scheduledcheckout.update_scheduled_checkout(scheduled_checkout_id: "scheduled_checkout_id")
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**scheduled_checkout_id:** `String` — scheduled_checkout_id
    
</dd>
</dl>

<dl>
<dd>

**execute_after:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**status:** `Schematic::Types::ScheduledCheckoutStatus` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Scheduledcheckout::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## accesstokens
<details><summary><code>client.accesstokens.<a href="/lib/schematic/accesstokens/client.rb">issue_temporary_access_token</a>(request) -> Schematic::Accesstokens::Types::IssueTemporaryAccessTokenResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.accesstokens.issue_temporary_access_token(
  lookup: {
    key: "value"
  },
  resource_type: "company"
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**lookup:** `Internal::Types::Hash[String, String]` 
    
</dd>
</dl>

<dl>
<dd>

**resource_type:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Accesstokens::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## webhooks
<details><summary><code>client.webhooks.<a href="/lib/schematic/webhooks/client.rb">list_webhook_events</a>() -> Schematic::Webhooks::Types::ListWebhookEventsResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.webhooks.list_webhook_events(
  q: "q",
  webhook_id: "webhook_id",
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**ids:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**q:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**webhook_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Webhooks::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.webhooks.<a href="/lib/schematic/webhooks/client.rb">get_webhook_event</a>(webhook_event_id) -> Schematic::Webhooks::Types::GetWebhookEventResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.webhooks.get_webhook_event(webhook_event_id: "webhook_event_id")
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**webhook_event_id:** `String` — webhook_event_id
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Webhooks::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.webhooks.<a href="/lib/schematic/webhooks/client.rb">count_webhook_events</a>() -> Schematic::Webhooks::Types::CountWebhookEventsResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.webhooks.count_webhook_events(
  q: "q",
  webhook_id: "webhook_id",
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**ids:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**q:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**webhook_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Webhooks::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.webhooks.<a href="/lib/schematic/webhooks/client.rb">list_webhooks</a>() -> Schematic::Webhooks::Types::ListWebhooksResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.webhooks.list_webhooks(
  q: "q",
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**q:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Webhooks::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.webhooks.<a href="/lib/schematic/webhooks/client.rb">create_webhook</a>(request) -> Schematic::Webhooks::Types::CreateWebhookResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.webhooks.create_webhook(
  name: "name",
  request_types: ["subscription.trial.ended"],
  url: "url"
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**credit_trigger_configs:** `Internal::Types::Array[Schematic::Types::CreditTriggerConfig]` 
    
</dd>
</dl>

<dl>
<dd>

**entitlement_trigger_configs:** `Internal::Types::Array[Schematic::Types::EntitlementTriggerConfig]` 
    
</dd>
</dl>

<dl>
<dd>

**name:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**request_types:** `Internal::Types::Array[Schematic::Types::WebhookRequestType]` 
    
</dd>
</dl>

<dl>
<dd>

**url:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Webhooks::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.webhooks.<a href="/lib/schematic/webhooks/client.rb">get_webhook</a>(webhook_id) -> Schematic::Webhooks::Types::GetWebhookResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.webhooks.get_webhook(webhook_id: "webhook_id")
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**webhook_id:** `String` — webhook_id
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Webhooks::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.webhooks.<a href="/lib/schematic/webhooks/client.rb">update_webhook</a>(webhook_id, request) -> Schematic::Webhooks::Types::UpdateWebhookResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.webhooks.update_webhook(webhook_id: "webhook_id")
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**webhook_id:** `String` — webhook_id
    
</dd>
</dl>

<dl>
<dd>

**credit_trigger_configs:** `Internal::Types::Array[Schematic::Types::CreditTriggerConfig]` 
    
</dd>
</dl>

<dl>
<dd>

**entitlement_trigger_configs:** `Internal::Types::Array[Schematic::Types::EntitlementTriggerConfig]` 
    
</dd>
</dl>

<dl>
<dd>

**name:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**request_types:** `Internal::Types::Array[Schematic::Types::WebhookRequestType]` 
    
</dd>
</dl>

<dl>
<dd>

**status:** `Schematic::Types::WebhookStatus` 
    
</dd>
</dl>

<dl>
<dd>

**url:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Webhooks::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.webhooks.<a href="/lib/schematic/webhooks/client.rb">delete_webhook</a>(webhook_id) -> Schematic::Webhooks::Types::DeleteWebhookResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.webhooks.delete_webhook(webhook_id: "webhook_id")
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**webhook_id:** `String` — webhook_id
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Webhooks::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.webhooks.<a href="/lib/schematic/webhooks/client.rb">count_webhooks</a>() -> Schematic::Webhooks::Types::CountWebhooksResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.webhooks.count_webhooks(
  q: "q",
  limit: 1000000,
  offset: 1000000
)
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**q:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` — Page limit (default 100)
    
</dd>
</dl>

<dl>
<dd>

**offset:** `Integer` — Page offset (default 0)
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `Schematic::Webhooks::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

