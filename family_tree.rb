require 'bundler/setup'
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)

def menu
  system 'clear'
  puts 'Welcome to the family tree!'
  puts 'What would you like to do?'
  gets.chomp
  loop do
    system 'clear'
    list
    puts 'Enter add [name] to add a person with name [name].'
    puts 'Enter edit [id] to edit relationships pertaining to [id].'
    puts 'Press e to exit.'
    choice = gets.chomp.split

    case choice[0]
    when 'add'
      choice.shift
      Person.create({:name => choice.join(' ')})
    when 'edit'
      choice.shift
      edit_relationships(choice[0].to_i)
    when 'm'
      add_marriage
    when 's'
      show_marriage
    when 'e'
      exit
    end
  end
end

def edit_relationships(person_id)
  loop do
    person = Person.find_by(id: person_id)
    system 'clear'
    #list people
    #list imediate relatives
    puts '
    Enter parents [id1], [id2] parents to this person.
    Enter spouse [spouse_id] spouse to this person.
    Enter child [child_id] [sigFig_id] to add child.
    Enter e to go back'
    input = gets.chomp.split
    case input[0]
    when 'parents'
      input.shift
      input = input.join.split(',')
      Parent.create({:spouse1_id => input[0].to_i, :spouse2_id => input[1].to_i})
    when 'spouse'
      input.shift
    when 'child'
      input.shift
    when 'e'
      break
    end
  end
end

def list
  if Person.all.length > 0
    puts 'Here are all the people:'
    puts 'id - name'
    puts '-------------------'
    people = Person.all
    people.each do |person|
      puts person.id.to_s + " " + person.name
    end
    puts "\n"
  end
end

menu
