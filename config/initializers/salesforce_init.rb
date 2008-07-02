# time zone offset issue
#
# Future refactoring of this issue
# 1. Move this to site yaml file once we move all site config into one yaml
# 2. Once we move to rails v2.1 we can solve the time-zone issue for events
#    You can get the time-zone offset for salesforce account by using owner_id
#    on any Contact record and then looking up owner in Sforce User table
SALESFORCE_TZ_OFFSET = {
  'events.servicenation.org' => -4
}
