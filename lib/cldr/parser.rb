=begin
  cldr/parser.rb - parse ldml data.

  Copyright (C) 2006 Masao Mutoh

  You may redistribute it and/or modify it under the same
  license terms as Ruby.

  $Id: parser.rb,v 1.1.1.1 2006/03/21 07:14:13 mutoh Exp $
=end

require 'rexml/document'

module CLDR
  module Parser
    def attribute(key, type)
      if @doc.elements[key]
	@doc.elements[key].attributes[type]
      else
	nil
      end
    end
    
    # parser functions.
    def attribute_only(var, meth, v, opts)
      attr = v.attributes[opts]
      if attr
	attr = ":empty:" if attr.size == 0
	{var.to_s => attr} 
      else
	{}
      end
    end
    
    def attribute_plural(var, meth, v, opts)
      attr_type = v.attributes["type"]
      result = opts.collect{|opt| v.attributes[opt]}.compact
      if result.size > 0
	result << "|#{v.text}" if v.text
      else
	result = v.text if v.text
      end
      key = var.to_s
      key += "|#{attr_type}" if attr_type
      {key => result} 
    end

    # proposed > draft > normal. 
    def parse(var, meth, element, *opts)
      data = {}
      data_draft = {}
      data_proposed = {}
      key = opts.shift
      id = var.to_s
      id += "|" + element.attributes["type"] if element.attributes["type"]
      
      element.get_elements(key).each do |v|
	if opts.size > 1
	  data.update(parse(id, meth, v, *opts))
	elsif opts.size == 1
	  ret = send(meth, id, meth, v, *opts)
	  if v.attributes["alt"] and v.attributes["alt"] == "proposed"
	    data_proposed.update(ret)
	  elsif v.attributes["draft"]
	    data_draft.update(ret)
	  else
	    data.update(ret)
	  end	    
	else
	  child_id = id.dup
	  child_id += "|" + v.attributes["type"] if v.attributes["type"]
	  if v.attributes["alt"] and v.attributes["alt"] == "proposed"
	    data_proposed[child_id] = v.text
	  elsif v.attributes["draft"]
	    data_draft[child_id] = v.text
	  else
	    data[child_id] = v.text
	  end
	end
      end
      
      data.update(data_draft).update(data_proposed)
      data
    end
  end
end
