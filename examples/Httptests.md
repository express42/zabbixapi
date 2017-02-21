# Httptests

This example assumes you have already initialized and connected the ZabbixApi.

For more information and available properties please refer to the Zabbix API documentation for Httptests:
[https://www.zabbix.com/documentation/3.2/manual/api/reference/httptest](https://www.zabbix.com/documentation/3.2/manual/api/reference/httptest)

## Create Web Scenario (httptest)
```ruby
zbx.httptests.create(
  :name => "web scenario",
  :hostid => zbx.templates.get_id(:host => "template"),
  :applicationid => zbx.applications.get_id(:name => "application"),
  :steps => [
    {
      :name => "step",
      :url => "http://localhost/zabbix/",
      :status_codes => 200,
      :no => 1
    }
  ]
)

# or use (lib merge json):
zbx.httptests.create_or_update(
  :name => "web scenario",
  :hostid => zbx.templates.get_id(:host => "template"),
  :applicationid => zbx.applications.get_id(:name => "application"),
  :steps => [
    {
      :name => "step",
      :url => "http://localhost/zabbix/",
      :status_codes => 200,
      :no => 1
    },
    {
      :name => "step 2",
      :url => "http://localhost/zabbix/index.php",
      :status_codes => 200,
      :no => 2
    }
  ]
)
```

## Update Web Scenario (httptest)
```ruby
zbx.httptests.update(
  :httptestid => zbx.httptests.get_id(:name => "web scenario"),
  :status => 0
)

#You can check web scenario:
puts zbx.httptests.get_full_data(:name => "web scenario")

