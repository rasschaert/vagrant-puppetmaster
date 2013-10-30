Vagrant Puppetmaster
====================
About
-----
It's pretty cool that Vagrant can provision machines with Puppet, but having a real Puppet master doing the provisioning in a Vagrant environment is even cooler.

You also have the added advantage of being able to used exported resources in PuppetDB and orchestration through MCollective.

This project uses the puppet provisioning of Vagrant to set up a bare minimum puppet master server, which can then do the rest of the provisioning of both itself and the other VM's.

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

  - Puppet Master running under Apache and Passenger
  - PuppetDB so you can use exported resources
  - Dnsmasq, which makes use of the exported resources to automatically make DNS records for all machines in this Vagrant environment
  - MCollective using ActiveMQ for orchestration

Project status
--------------
  - The puppet master works, although it's still using Webrick instead of Passenger
  - PuppetDB is OK
  - Dnsmasq is OK
  - MCollective has not yet been added
