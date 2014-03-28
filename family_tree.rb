require 'bundler/setup'
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)

def menu
  system 'clear'
  puts "Welcome to the family tree! \n..."
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
    list
    list_imediate_relatives(person_id)
    puts '
    Enter parents [father_id], [mother_id] parents to this person.
    Enter spouse [spouse_id] spouse to this person.
    Enter child [child_id], [sigFig_id] to add child.
    Enter e to go back'
    input = gets.chomp.split
    case input[0]
    when 'parents'
      input.shift
      input = input.join.split(',')
      Parent.create({:father_id => input[0].to_i, :mother_id => input[1].to_i, :person_id => person_id})
    when 'spouse'
      input.shift
      Marriage.create({:spouse1_id => input[0].to_i, :spouse2_id => person_id, :divorced => false})
    when 'child'
      input.shift
      input = input.join.split(',')
      Parent.create({:person_id => input[0].to_i,  :mother_id => input[1].to_i, :father_id => person_id})
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

def list_imediate_relatives(person_id)
  papa = Person.find_by(id: Parent.find_by(person_id: person_id).father_id)
  mama = Person.find_by(id: Parent.find_by(person_id: person_id).mother_id)

  spouse = Person.find_by(id: Parent.find_by(person_id: person_id).father_id)
  puts "*"*10
    puts "here are this persons immediate relatives"
    puts "parents"
    puts "le Papa: #{pplz.father_id}"
    puts "ma mère: #{pplz.mother_id}"
    puts "époux"
    list_spouse(find_spouse(person_id))
    p
  puts "*"*10
end

def find_spouse(person_id)
  opt1 = Marriage.where(spouse1_id: person_id)
  opt2 = Marriage.where(spouse2_id: person_id)
  (opt1 << opt2).flatten
end

def list_spouse()

end


menu
