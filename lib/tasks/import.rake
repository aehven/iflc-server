require 'csv'

namespace :data do
  namespace :import do
    desc "Create all survey templates"
    task :all => [:accounts, :contacts]

    desc "Importing accounts from accounts.csv"
    task :accounts => :environment do
      file = "accounts.csv"

      CSV.foreach(file, :headers => true) do |row|
        create_account(row)
      end
    end

    desc "Importing contacts"
    task :contacts => :environment do
      file = "contacts.csv"

      CSV.foreach(file, :headers => true) do |row|
        create_contact(row)
      end
    end
  end
end

def create_contact(row)
  #First name, Last name, Salutation, Title, Account name
  #     0          1         2          3          4

  puts "#{row[0]} #{row[1]}"

  account_name = row[4].blank? ? "Unknown Account" : row[4]

  a = Account.find_by(name: account_name)
  if !a
    a = Account.find_or_create_by(name: account_name)
    puts "== Couldn't find account #{account_name} for contact #{row[0]} #{row[1]}; creating it now."
  end

  c = Contact.create(first_name: row[0], last_name: row[1])
  a.contacts << c
end

def create_account(row)
  # Name,Website,Main Phone,Fax,Address 1 Street,Address 1 City,
  #  0     1        2        3         4              5
  # Address 1 State,Address 1 Postal Code,Activity,FD1,Office Manager,RC,Type,FD2
  #          6                7              8      9        10       11  12   13

  puts row[0]
  a = Account.find_by(name: row[0])

  if(a)
    puts "== Account with name #{row[0]} duplicate entry."
  end

  a = Account.create(
    name: row[0],
    phone: row[2],
    street: row[4],
    city: row[5],
    zip: row[7],
    fd1: row[9],
    fd2: row[13],
    rc: row[11],
    kind: row[12]&.camelize
  )

  Activity.create(account: a, date: DateTime.parse("1970-01-01"), text: row[8])

  a
end

# def create_by_phone(row)
#   puts row[5]
#   a = Account.find_by(phone: row[5])
#
#   if(a)
#     puts "Account with phone #{row[5]} duplicate entry."
#   else
#     a = Account.create(phone: row[5])
#   end
#
#   a.update_attributes(
#     name: row[4],
#     street: row[3],
#     city: row[1],
#     zip: row[2]
#   )
#
#   a
# end
