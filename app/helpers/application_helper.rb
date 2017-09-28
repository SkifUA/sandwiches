module ApplicationHelper
  def login_helper(styles = '')
    if current_user
      link_to t('logout'), destroy_user_session_path, method: :delete, class: styles
    else
      (link_to t('sign_up'), new_user_registration_path, class: styles) +
          " ".html_safe +
          (link_to t('login'), new_user_session_path, class: styles)
    end
  end
end
