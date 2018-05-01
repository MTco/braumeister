# This code is free software; you can redistribute it and/or modify it under
# the terms of the new BSD License.
#
# Copyright (c) 2012-2017, Sebastian Staudt

require 'rails_helper'

describe FormulaeController do

  describe '#select_repository' do
    it 'sets the repository' do
      controller.expects(:params).returns repository_id: 'Homebrew/homebrew-php'

      controller.expects :not_found

      controller.send :select_repository
    end

    it 'the repository defaults to nil' do
      controller.send :select_repository

      expect(controller.instance_variable_get(:@repository)).to be_nil

     controller.send :select_repository
    end

    it 'redirects to the base URL for Homebrew/homebrew-core' do
      controller.expects(:params).returns repository_id: 'Homebrew/homebrew-core'
      request = mock
      request.expects(:url).returns 'http://formulae.brew.sh/repos/Homebrew/homebrew-core/browse'
      controller.expects(:request).returns request

      controller.expects(:redirect_to).with 'http://formulae.brew.sh/browse', status: :moved_permanently

      controller.send :select_repository
    end
  end

  describe '#show' do
    context 'when formula is not found' do
      before do
        Formula.expects(:all_in).returns []
        Formula.expects(:includes).returns mock(where: [])
        repo = mock

        controller.stubs :select_repository
        controller.instance_variable_set :@repository, repo
        bypass_rescue
      end

      it 'should raise an error' do
        expect(-> { get :show, params: { repository_id: 'Homebrew/homebrew-versions', id: 'git' }}).
          to raise_error(Mongoid::Errors::DocumentNotFound)
      end
    end
  end

end
