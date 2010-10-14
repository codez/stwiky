
desc "Creates or resets the sandbox user with a default board"
task :sandbox => :environment do
  sandbox = User.find_by_name 'sandbox'
  sandbox = User.create! :name => 'sandbox', :password => '' if sandbox.nil?
  sandbox.boards.clear
  sandbox.add_default_board
  sandbox.boards.first.notes.create!(:content => "h1. Sandbox\n\nFeel free to play around in here!",
                                     :pos_x => 650,
                                     :pos_y => 50,
                                     :width => 200,
                                     :height => 100)
end