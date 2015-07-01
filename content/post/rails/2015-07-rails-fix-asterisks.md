+++
title = "Rails: Allow users to use asterisks as wildcards."
Tags = ["ruby", "rails"]
date = "2015-07-01T10:17:12-06:00"

+++

Simple method that iterates a hash and any string values that contain an asterisk
are changed to a percent sign.  It will *not* iterate to sub hashes.
<!--more-->

~~~ ruby
def fix_asterisks hash
  hash = hash.dup
  hash.each_pair do |key, val|
    if val.is_a?(String) && val =~ /\*/
      hash[key] = val.gsub(/\*/, '%')
    end
  end
end

def controller_action
  query = QueryObject.new(fix_asterisks(params[:query]))
end
~~~

### Examples

~~~ ruby
def controller_action
  query = QueryObject.new(fix_asterisks(params[:query]))
  ...

  # params[:query][:last_name] = "smith*"
  p query.last_name
  # => "smith%"

  # params[:query][:last_name] = "smith%"
  p query.last_name
  # => "smith%"

  # params[:query][:days] = "13"
  p query.days
  # => "13"
  ...

  objs = Customer.where(['last_name like ?', query.last_name])
end
~~~
