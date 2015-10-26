module SpicedRumby
  module GUI
    module Views
      class Chat < Vedeu::ApplicationView

        cattr_accessor :messages

        def initialize(*)
          super
          self.messages = []
        end

        def self.add_message(kind, text)
          messages << {
            kind: kind,
            message: text
          }
          Vedeu.log(type: :update, message: kind.to_s + ": " + text)
          Vedeu.log(type: :update, message: "num: " + messages.count.to_s)
          Vedeu.trigger(:_refresh_)
          SpicedRumby::GUI::Controllers::Chat.chats[:all].render(messages)
          SpicedRumby::GUI::Controllers::Chat.contacts_list.render
        end

        def render(messages = nil)
          Vedeu.render do
            view :chat do
              background SpicedRumby::GUI::Colorer::BACKGROUND
              geometry do
                input = use(:input)
                align :top, :left, input.width, input.north
              end

              messages ||= SpicedRumby::GUI::Views::Chat.messages
              # lines do
                messages.each do |message|
                  SpicedRumby::GUI::Colorer.send(message[:kind], self, message[:message])
                end
              # end
            end
          end
        end

      end
    end
  end
end
