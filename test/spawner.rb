class Sequel::Model
  def self.spawn(attributes = {})
    record = new(attributes)
    record.send(:before_spawn)
    record
  end

  def self.spawn!(attributes = {})
    record = new(attributes)
    record.send(:before_spawn)
    record.save
    record.send(:after_spawn)
    record
  end

  private

  def before_spawn
  end

  def after_spawn
  end
end


class Resource
  def before_spawn
    self.title ||= 'Dummy title'
    self.published ||= true
  end
end

class User
  def before_spawn
    id = random_id
    self.first_name ||= 'John'
    self.last_name ||= 'Doe'
    self.email ||= "foo_#{random_id}@bar.com"
    self.username ||= "user_#{random_id}"
  end
end

class Advocate
  def before_spawn
    id = random_id
    self.first_name ||= 'John'
    self.last_name ||= 'Doe'
    self.email ||= "foo_#{random_id}@bar.com"
    self.username ||= "user_#{random_id}"
    self.crypted_password ||= 'test'
  end
end

class Tag
  def before_spawn
    self.name ||= "fun_tag_#{random_id}"
  end
end

class Question
  def before_spawn
    self.stem ||= "This is the question stem"
  end
end

class Choice
  def before_spawn
    self.stem ||= "This is the choice stem"
    self.question ||= Question.spawn!
  end
end

class Response
  def before_spawn
    self.user ||= Guest.spawn!
    self.choice ||= Choice.spawn!
    self.question = self.choice.question
  end
end

class Address
  def before_spawn
    self.street ||= '1234 Main St'
    self.city ||= 'Washington'
    self.state ||= 'DC'
    self.zipcode ||= '20009'
  end
end
