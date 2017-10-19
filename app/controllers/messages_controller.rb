class MessagesController < ApplicationController
	before_action :require_login

	def create
		event_id = params[:message][:event_id]
		@message = Message.create(message_params)

		return redirect_to event_path(event_id) if @message.valid?

		flash[:errors] = @message.errors.full_messages

		return redirect_back fallback_location: event_path(event_id)

	end

	private
		def message_params
				params.require(:message).permit(:content, :event_id).merge(user: current_user)
	end
end
