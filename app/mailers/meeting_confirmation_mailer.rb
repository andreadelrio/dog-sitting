class MeetingConfirmationMailer < ActionMailer::Base
  default from: "\"Kmimos\" <reservas@cani.mx>"


  def new_meeting_notification(meeting)
    @meeting = meeting
    mail(
      to: @meeting.user_email,
      subject: 'Solicitud recibida.')
  end

  def new_meeting_for_admin(meeting)
    @meeting = meeting
    mail(
      # to: "adelrio@ayuinc.com",
      # to: "r.cuevas@desdigitec.com",
      # cc: "r.gonzalez@desdigitec.com",
      subject: 'Nueva solicitud en Kmimos')
  end
end
