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
