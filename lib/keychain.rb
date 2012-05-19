# blog post: http://blog.slashpoundbang.com/post/1521530410/accessing-the-os-x-keychain-from-ruby

class KeyChain
  def self.method_missing(meth, *args)
    run args.unshift(meth)
  end

  def self.find_internet_password(*args)
    # -g: Display the password for the item found
    output = quiet args.unshift('find-internet-password', '-g') 
    output[/^password: "(.*)"$/, 1]
  end

private

  def self.run(*args)
    `security #{args.join(' ')}`
  end
  
  def self.quiet(*args)
    run args.unshift('2>&1 >/dev/null')
  end
end
