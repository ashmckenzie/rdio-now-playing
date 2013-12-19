require 'sinatra/base'
require 'sinatra/reloader'

require 'awesome_print'
require 'rdio_api'

class RdioNowPlaying < Sinatra::Base

  RDIO_CONSUMER_KEY = 'pjqtmccth7p44hfnw9j7vqn8'
  RDIO_CONSUMER_SECRET = 'zDxvyNy7Ax'

  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    @user = rdio_client.findUser(email: 'metcalfe.phil@gmail.com')
    @activity = rdio_client.getActivityStream(user: @user[:key], scope: 'user')
    @current_track = @activity.updates.first['playlist']['ownerObj']['lastSongPlayed']
    erb :index
  end

  private

    def rdio_client
      @rdio_client ||= RdioApi.new(consumer_key: RDIO_CONSUMER_KEY, consumer_secret: RDIO_CONSUMER_SECRET)
    end
end
