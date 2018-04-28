# This code is free software; you can redistribute it and/or modify it under
# the terms of the new BSD License.
#
# Copyright (c) 2014-2018, Sebastian Staudt

require 'rails_helper'

describe ApplicationHelper do

  describe '#formulae_link' do
    it 'provides links to formulae' do
      repo = Repository.core
      formula = repo.formulae.find_or_create_by name: 'git'
      formula.repository = repo

      expect(helper.formula_link(formula)).to eq('<a class="formula" href="/formula/git">git</a>')
    end
  end

  describe '#timestamp' do
    it 'provides a timestamp tag' do
      time = ActiveSupport::TimeZone['Berlin'].at 1397573100
      expect(helper.timestamp(time)).to eq('<time class="timeago" datetime="2014-04-15T14:45:00Z">April 15, 2014 16:45</time>')
    end
  end

  describe '#title' do
    it 'provides a default title' do
      expect(helper.title).to eq('Homebrew Formulae')
    end

    it 'provides customized titles' do
      assign :title, 'Custom Title'
      expect(helper.title).to eq('Custom Title – Homebrew Formulae')
    end
  end

end
