if( rEvent === undefined ) { var rEvent = function() { return { }; }; }

rEvent.display = ( function() {
  var self =  {
    url: "http://greenforall.e.zheng.radicaldesigns.org/greenforall/events/show/",
    item: function( item ) {
      var item_container = $(document.createElement('div').addClassName('partner-event-item'));
      if ( !(item.category === undefined)) {
        item_container.addClassName('category_'+item.category); 
      }
      var location = $(document.createElement('div')).addClassName('revent_location location').update( '<a href="'+self.url+item.id+'">'+( item.city || "" ) + ", " + ( item.state || "" )+'</a>');
      var title = $(document.createElement('h4')).addClassName('revent_title title' ).update( item.name );
      // var description = $(document.createElement('p')).addClassName('revent_desc desc').update( ( item.description || "" ) );
      var start_date = $(document.createElement('div')).addClassName('revent_date date').update( ( (item.segmented_date.month+'/'+item.segmented_date.day) || "" ) );
      item_container.appendChild( location );
      item_container.appendChild( title );
      item_container.appendChild( start_date );
      //item_container.appendChild( description );
      return item_container;
    },
    list: function( items, display_id ) {
      // default id is revent_list
      if ( display_id === undefined ) { display_id = 'revent_list' };

      // create a display container unless one already exists
      if ( $(display_id) === null ) { 
        var container = $(document.createElement('div'));
        container.id = display_id;
        document.appendChild( container );
      } else {
        var container = $(display_id);
        container.innerHTML = '';
      }
      if( items.length > 0 ) {      
        var introtext = $(document.createElement('div')).addClassName('intro-text').update( 'Join our partners at Green Jobs Now for events in your area >>');
        container.appendChild( introtext );
      }
      items.each( function(item) {
        container.appendChild( rEvent.display.item( item ) );
      } );
    }
  };
  return self;
})();
