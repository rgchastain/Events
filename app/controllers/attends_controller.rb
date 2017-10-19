class AttendsController < ApplicationController
	before_action :require_login
	def create
		event = Event.find(params[:id])

		Attend.create(user:current_user, event:event) unless event.attendees.include? current_user	
		
		return redirect_to '/events'
	end


	def destroy
		event = Event.find(params[:id])

		attend = Attend.find_by(event: event, user: current_user)

		attend.delete unless attend === nil

		return redirect_to '/events'
	end
end
