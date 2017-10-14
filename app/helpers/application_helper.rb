module ApplicationHelper
  def login_helper(tag: :li, styles: '')
    if current_user
      content_tag( tag,(link_to t('logout'), destroy_user_session_path, method: :delete, class: styles))
    else
      (content_tag( tag,(link_to t('sign_up'), new_user_registration_path, class: styles))) +
          " ".html_safe +
          (content_tag( tag,(link_to t('login'), new_user_session_path, class: styles)))
    end
  end

  def alerts
    alert = flash[:notice] || flash[:error] || flash[:alert]
    if alert
      alert_generator(alert)
    end
  end

  def alert_generator(msg)
    js add_gritter(msg, title: "Test Website", sticky: false)
  end
end
