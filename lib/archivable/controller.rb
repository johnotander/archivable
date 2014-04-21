require 'active_support/concern'
require 'meta_magic'

module Archivable
  module Controller
    include MetaMagic::Controller
    extend ActiveSupport::Concern

    def archive
      archivable_model = set_model_instance_variable
      archivable_model.toggle(:archived)

      respond_to do |format|
        if archivable_model.save
          format.html { render :show, notice: get_archivable_flash(archivable_model, success: true) }
        else
          format.html { render :show, alert: get_archivable_flash(archivable_model, success: false) }
        end
      end
    end

    def get_archivable_flash(model, opts = {})
      "#{ model.class.name } was"\
      "#{ ' not' unless opts[:success] } "\
      "#{ model.archived ? :archived : :unarchived } "\
      "successfully."
    end
  end
end