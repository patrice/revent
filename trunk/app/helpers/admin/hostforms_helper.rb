module Admin::HostformsHelper

def site_id_form_column( record, input_name )
  return Site.find( record.site_id ).host if record.site_id
  record.site_id = Site.current.id
  text_field( :record, :site_id )
end
def calendar_form_column( record, input_name )
  select_tag input_name, options_for_select(Site.current.calendars.map{ |c| [c.name, c.id] })
end
end