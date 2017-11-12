# This code is free software; you can redistribute it and/or modify it under
# the terms of the new BSD License.
#
# Copyright (c) 2017, Sebastian Staudt

require 'main_import'

describe MainImport do

  let(:repo) do
    repo = Repository.new name: Repository::MAIN
    repo.extend subject
  end

  describe '#create_missing_taps' do

    before do
      repo.expects(:official_taps).returns %w(apache php)
    end

    it 'should create a repository for missing taps' do
      Repository.expects(:find).with('Homebrew/homebrew-apache').returns mock(outdated?: false)
      Repository.expects(:find).with('Homebrew/homebrew-php').returns nil

      Repository.expects(:create).with name: 'Homebrew/homebrew-php', outdated: false
      Rails.logger.expects(:info).with 'Created tap repository for Homebrew/homebrew-php.'

      repo.create_missing_taps
    end

    it 'should do nothing with existing taps' do
      Repository.expects(:find).with('Homebrew/homebrew-apache').returns mock(outdated?: false)
      Repository.expects(:find).with('Homebrew/homebrew-php').returns mock(outdated?: false)

      Repository.expects(:create).never
      Rails.logger.expects(:info).never

      repo.create_missing_taps
    end

  end

  describe '#deprecated_official_taps' do

    it 'should return DEPRECATED_OFFICIAL_TAPS from brew' do
      repo.expects(:path).returns '/repo'
      file_contents = 'DEPRECATED_OFFICIAL_TAPS = %w{apache php}'
      File.expects(:read).with('/repo/Library/Homebrew/official_taps.rb').
              returns file_contents

      expect(repo.deprecated_official_taps).to eq(%w{apache php})
    end

  end

  describe '#official_taps' do

    it 'should return OFFICIAL_TAPS from brew' do
      repo.expects(:path).returns '/repo'
      file_contents = 'OFFICIAL_TAPS = %w{apache php}'
      File.expects(:read).with('/repo/Library/Homebrew/official_taps.rb').
              returns file_contents

      expect(repo.official_taps).to eq(%w{apache php})
    end

  end

  describe '#update_deprecated_taps' do

    it 'should mark deprecated taps' do
      apache = Repository.new
      php = Repository.new

      repo.expects(:deprecated_official_taps).returns %w{apache php}
      Repository.expects(:find).with('Homebrew/homebrew-apache').returns apache
      Repository.expects(:find).with('Homebrew/homebrew-php').returns php

      repo.update_deprecated_taps

      expect(apache).to be_outdated
      expect(php).to be_outdated
    end

  end

  describe '#update_status' do

    before do
      module RepositoryImport
        alias_method :update_status_orig, :update_status
        def update_status
          'deadbeef'
        end
      end
    end

    it 'should save if the commit ID did change' do
      repo.sha = '01234567'
      repo.expects(:save!)

      expect(repo.update_status).to eq('deadbeef')
    end

    it 'should skip saving if the commit ID did not change' do
      repo.sha = 'deadbeef'
      repo.expects(:save!).never

      expect(repo.update_status).to eq('deadbeef')
    end

    after do
      module RepositoryImport
        alias_method :update_status, :update_status_orig
      end
    end

  end

end
