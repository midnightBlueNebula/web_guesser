require 'sinatra'
require 'sinatra/reloader'

def check_guess(guess,secret,color)
    if guess == secret
        $color = "lightgreen"
        "Correct!!!"
    elsif guess > secret
        if guess > secret + 9
            $color = "lightblue"
            return "Too high :("
        else
            $color = "pink"
            return "High. You're this close..."
        end
    else
        if guess < secret - 9
            $color = "lightblue"
            return "Too low :("
        else
            $color = "pink"
            return "Low. You're this close..."
        end
    end
end

@@guess_left = 5

secret = rand(101)
get '/' do
    cheat = ""
    $color = "lightblue"
    guess = params['guess']
    cheat = params['cheat']
    message = check_guess(guess.to_i,secret,$color)

    if message != "Correct!!!"
        @@guess_left -= 1 
    else
        @@guess_left = 5
        secret = rand(101)
    end

    if @@guess_left == 0
        cheat = "true"
        @@guess_left = 5
        secret = rand(101)
    end

    erb :index, :locals => {:secret => secret, :message => message, :color => $color, :guess_left => @@guess_left, :cheat => cheat}
end