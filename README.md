Vagrant Puppetmaster
=================================
About
-----
It's pretty cool that Vagrant can provision machines with Puppet, but having a real Puppet master doing the provisioning in a Vagrant environment is even cooler. This project uses the puppet provisioning of Vagrant to set up a bare minimum puppet master server, which can then do the rest of the provisioning of both itself and the other VM's.

2 stages of provisioning
------------------------

### Stage 1
This stage just does what's necessary to get the master up and running so that the agent can fetch his catalog.

  - Just Enough Puppet Master
  - Autosign certificates
  - No DNS
  - Start the agent to get stage 2 going

### Stage 2
This stage uses the JEPM to set up a more complete stack.

  - DNSMasq
  - MCollective
  - PuppetDB

Project status
-----------------------------
This project is not yet in a usable state.
