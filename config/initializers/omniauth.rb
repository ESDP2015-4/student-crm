Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, "907497187323-4svde7p9q09s8tqvo6qj14c02jtr03r6.apps.googleusercontent.com",
           "yzjuDIehwLebdZYEETQj7Y4h", {
               scope: ['email',
                       'profile',
                       'https://www.googleapis.com/auth/gmail.modify',
                       'https://www.googleapis.com/auth/drive'],
               access_type: 'offline',
               skip_jwt: true}
end