class InlineInput < SimpleForm::Inputs::Base
  def input
    "<span>#{@builder.text_field(attribute_name, input_html_options)}</span>".html_safe
  end
end