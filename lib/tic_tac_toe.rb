class TicTacToe 
    WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,3,6],[1,4,7],[2,5,8],[0,4,8],[6,4,2]]

    def initialize
        @winner = nil
        @board = Array.new(9, " ")
    end

    def display_board
        puts (" X | X | X ")
        puts ("-----------")
        puts (" X | O | O ")
        puts ("-----------")
        puts (" X | O | O ")
        puts (" X | O | X ")
        puts ("-----------")
        puts (" O | X | X ")
        puts ("-----------")
        puts (" O | X | O ")
    end

    def input_to_index(input)
        if (input.to_i != 0) # checks whether a number was entered
            input = input.to_i
        else
            return "string"
        end
        return input - 1 if proper_number?(input, true)
    end

    def move(position, player)
        @board[position] = player
    end

    def position_taken?(position)
        @board[position] != " "
    end

    def valid_move?(position)
        position_taken?(position) == false && proper_number?(position)
    end

    def turn_count
        count = 0
        @board.each do |square|
            count += 1 if square != " "
        end
        count
    end

    def current_player
        turn_count % 2 == 0 ? 'X' : 'O'
    end

    def turn
        valid = false
        while !valid do
            move = gets
            input = input_to_index(move)
            valid = true if input != "string" && (valid_move?(input))
        end
        @board[input] = current_player
        display_board
        @board
    end

    def won?
        winning_arrangement = nil
        WIN_COMBINATIONS.each do |combo|
            matches = 0
            tally_hash = { :x => 0, :y => 0 }
            combo.each do |number|
                if @board[number] != ' '
                    if @board[number] == 'X'
                        tally_hash[:x] += 1
                    else
                        tally_hash[:y] += 1
                    end
                end 
            end
            if tally_hash[:x] == 3 || tally_hash[:y] == 3
                @winner = tally_hash[:x] == 3 ? 'X' : 'O'
                winning_arrangement = combo  
            end
        end
        winning_arrangement
    end

    def full?
        turn_count == 9
    end

    def draw?
        full? && !won?
    end

    def over?
        draw? || won?
    end 

    def winner 
        won?
        @winner
    end

    def play
        while !over?
            turn
        end
        if winner
            puts "Congratulations #{@winner}!"
        else
            puts "Cat's Game!"
        end
    end


    private

    def proper_number?(input, user_input = false)
        adjust_for_user = user_input ? 1 : 0 # A user will enter a number 1 higher than the array expects. Ajustment is needed
        if (input >= (0 + adjust_for_user) && (input < 9 + adjust_for_user)) && (input % 1 == 0)
            return true
        else
            return false
        end
    end

end