# Actions

This example assumes you have already initialized and connected the ZabbixApi.

For more information and available properties please refer to the Zabbix API documentation for Actions:
[https://www.zabbix.com/documentation/3.2/manual/api/reference/action](https://www.zabbix.com/documentation/3.2/manual/api/reference/action)

## Create Action based on Trigger
```ruby
zbx.actions.create(
  :name => "trigger action",
  :eventsource => '0',                    # event source is a triggerid
  :status => '0',                         # action is enabled
  :esc_period => '120',                   # how long each step should take
  :def_shortdata => "Email header",
  :def_longdata => "Email content",
  :maintenance_mode => '1',
  :filter => {
      :evaltype => '1',                   # perform 'and' between the conditions
      :conditions => [
          {
              :conditiontype => '3',      # trigger name
              :operator => '2',           # like
              :value => 'pattern'         # the pattern
          },
          {
              :conditiontype => '4',      # trigger severity
              :operator => '5',           # >=
              :value => '3'               # average
          }
      ]
  },
  :operations => [
      {
          :operationtype => '0',              # send message
          :opmessage_grp => [                 # who the message will be sent to
              {
                  :usrgrpid => '2'
              }
          ],
          :opmessage => {
              :default_msg => '0',            # use default message
              :mediatypeid =>  '1'            # email id
          }
      }
  ],
  :recovery_operations => [
      {
          :operationtype => '11',             # send recovery message
          :opmessage_grp => [                 # who the message will be sent to
              {
                  :usrgrpid => '2'
              }
          ],
          :opmessage => {
              :default_msg => '0',            # use default message
              :mediatypeid =>  '1'            # email id
          }
      }
  ]
)
# In Zabbix 3.2 and higher actions now have a maintenance_mode property which pauses notifications during host maintenance
# A separate action condition for Maintenance status = not in “maintenance” is no longer needed
```

