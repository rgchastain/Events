class EventsController < ApplicationController
	before_action :require_login
	def index
		@user = User.find(current_user)
		@user_state = Event.where(state: current_user.state)
		@other_states = Event.where.not(state: current_user.state)
		@states =["AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY" ]
	end

	def create
		@event = Event.new(event_params)

		if @event.save
			flash[:notice] = ["Successfully created event"]
			return redirect_to events_path
		end
		flash[:errors] = @event.errors.full_messages
		return redirect_to :back
	end

	def destroy
		@event = Event.find(params[:id])

		@event.delete if @event.user == current_user

		return redirect_to events_path(current_user)
	end

	def show
		@event = Event.find(params[:id])
		@message = Message.all
	end

	def edit
		@event = Event.find(params[:id])
		@states =["AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY" ]
	end

	def update
		@event = Event.find(params[:id])

  		if @event.update(event_params)
			flash[:notice] = ["Successfully updated event"]
			return redirect_to events_path
 		end

 		flash[:errors] = @event.errors.full_messages
			return redirect_to :back
	end


	private
		def event_params
			params.require(:event).permit(:name, :date, :city, :state).merge(user: current_user)
		end
end
