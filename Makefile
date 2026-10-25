.PHONY: test brew-cleanup-before brew-setup brew-tap-syntax brew-formulae brew-verify

TEST_BOT_FORMULAE ?= gsd-pi

brew-cleanup-before:
	brew test-bot --only-cleanup-before

brew-setup:
	brew test-bot --only-setup

brew-tap-syntax:
	brew test-bot --only-tap-syntax

brew-formulae:
	brew test-bot --only-formulae --testing-formulae=$(TEST_BOT_FORMULAE)

brew-verify: brew-cleanup-before brew-setup brew-tap-syntax brew-formulae

test: brew-verify
