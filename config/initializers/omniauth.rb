Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, "",
           "", {
               scope: ['email',
                       'profile',
                       'https://www.googleapis.com/auth/gmail.modify',
                       'https://www.googleapis.com/auth/drive'],
               access_type: 'offline',
               skip_jwt: true}
end