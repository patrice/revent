class :CLASS:Controller < ActionController::Base
	def index
		list
		render :action => 'list'
	end

	verify :method => :post, :only => [ :destory, :create, :update ],
					:redirect_to => { :action => :list }

	def list
		@:TABLE:s = :CLASS:.find(:all)
#		@:TABLE:_pages, @:TABLE:s = paginate ::TABLE:s, :per_page => 20
	end

	def show
		@:TABLE: = :CLASS:.find(params[:id])
		if @:TABLE: == nil
			render :text => params[:id].to_s + ' is an invalid key.'
		end
	end

	def new
		@:TABLE: = :CLASS:.new
	end

	def create
		@:TABLE: = :CLASS:.new(params[::TABLE:])
		if @:TABLE:.save
			flash[:notice] = ':CLASS: was successfully created'
			redirect_to :action => 'list'
		else
			render :action => 'new'
		end
	end

	def edit
		@:TABLE: = :CLASS:.find(params[:id])
	end

	def update
		@:TABLE: = :CLASS:.find(params[:id])
		@:TABLE:.update_atts(params[::TABLE:])
		if @:TABLE:.save
			flash[:notice] = ':CLASS: ' + params[:id] + ' was successfully editted'
			redirect_to :action => 'show', :id => params[:id]
		else
			render :action => 'edit'
		end
	end

	def destroy
		:CLASS:.destroy(params[:id])
		redirect_to :action => 'list'
	end
end
