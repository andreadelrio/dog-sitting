class MeetingsController < ApplicationController
	before_action :set_meeting, only: [:show]

	def new
		session[:chosen_provider_id] = params[:provider_id]
	  @meeting = Meeting.new
	end

	def show
	end

	def create 
		@meeting = Meeting.new(meeting_params)
	  if @meeting.save
    	MeetingConfirmationMailer.new_meeting_notification(@meeting).deliver
    	MeetingConfirmationMailer.new_meeting_for_admin(@meeting).deliver
	    session[:start_date] = nil
	    session[:end_date] = nil
      	session[:user_email] = nil
	    redirect_to  meeting_path(@meeting)
	  else
	    render 'new'
	  end
	end


	private

	def meeting_params
	  params.require(:meeting).permit(:user_first_name, :user_last_name, :provider_id, :user_phone, :user_email)
	end

	def set_meeting
    @meeting = Meeting.find_by_token(params[:id])
  end

	def get_dates
	  unless params[:start_date].nil? || params[:start_date].empty?
	    session[:start_date] = Date.strptime(params[:start_date],'%d/%m/%Y')
	  end
	  unless params[:start_date].nil? || params[:start_date].empty?
	    session[:end_date] = Date.strptime(params[:end_date],'%d/%m/%Y')
	  end
	end

end