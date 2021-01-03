require_relative 'prompt/version'
require 'gtk3'

module Prompt
  class Error < StandardError; end

  module_function
  def ask(question)
    builder_file = "#{__dir__}/../myapp.glade"
    builder = Gtk::Builder.new(file: builder_file)

    ret = nil
    win = builder.get_object('win')
    yes = builder.get_object('yes')
    yes.signal_connect('clicked') do
      ret = true
      Gtk.main_quit
    end
    no = builder.get_object('no')
    no.signal_connect('clicked') do
      ret = false
      Gtk.main_quit
    end
    q = builder.get_object('question')
    q.set_markup(question)
    win.signal_connect('destroy') do
      ret = false
      Gtk.main_quit
    end
    win.show_all
    Gtk.main
    ret
  end
end
