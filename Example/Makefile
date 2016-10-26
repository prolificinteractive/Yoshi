RUBY_VERSION=$(shell cat .ruby-version)

# SETUP
install: install-rvm install-bundler install-pods

install-rvm:
	@\curl -sSL https://get.rvm.io | bash -s stable --ruby=${RUBY_VERSION} || true
	@source ${HOME}/.rvm/scripts/rvm && rvm use ${RUBY_VERSION}

install-bundler:
	@gem install bundler
	@bundle install

install-pods:
	@pod repo update
	@pod install
