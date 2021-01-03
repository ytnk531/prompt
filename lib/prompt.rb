require_relative 'prompt/version'
require 'gtk3'

module Prompt
  class Error < StandardError; end

  module_function

  def ask_input(question)
    ret = nil
    window = Gtk::Window.new
    setup_input_dialog window, question

    Gtk.main
    @ret
  end

  def setup_input_dialog(window, question)
    dialog = Gtk::Dialog.new(
      parent: window,
      title: 'Asking...',
      buttons: [[Gtk::Stock::OK, :ok]]
    )
    content_area = dialog.child
    label = Gtk::Label.new(question)
    entry = Gtk::Entry.new
    content_area.pack_start label, expand: true, padding: 10
    content_area.pack_start entry, padding: 10
    dialog.signal_connect('response') do |_widget, _response|
      @ret = entry.text
      Gtk.main_quit
    end
    dialog.show_all
    dialog
  end

  def ask(question)
    window = Gtk::Window.new
    setup_dialog window, question

    Gtk.main
    @ret
  end

  def setup_dialog(window, question)
    dialog = Gtk::Dialog.new(
      parent: window,
      title: 'Asking...',
      buttons: [[Gtk::Stock::YES, :yes],
                [Gtk::Stock::NO, :no]]
    )
    content_area = dialog.child
    label = Gtk::Label.new(question)
    content_area.pack_start label, expand: true, padding: 10
    dialog.signal_connect('response') do |_widget, response|
      @ret = case response
             when Gtk::ResponseType::YES
               true
             when Gtk::ResponseType::NO
               false
             end
      Gtk.main_quit
    end
    dialog.show_all
    dialog
  end
end
