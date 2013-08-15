class Class
  def attr_accessor_with_history(attr_name)
    attr_name = attr_name.to_s   # make sure it's a string
    attr_reader attr_name        # create the attribute's getter
		# create '_history' getter
    class_eval %Q{def #{attr_name}_history
										if !@#{attr_name}_history
											@#{attr_name}_history = Array.new
											@#{attr_name}_history.push nil
										end
										return @#{attr_name}_history
									end}
		# create '_history' setter
		class_eval %Q{def #{attr_name}= (value)
									@#{attr_name} = value
									if !@#{attr_name}_history
											@#{attr_name}_history = Array.new
											@#{attr_name}_history.push nil
										end
									@#{attr_name}_history.push value
								end}
  end
end