resources { 'firewall':
  purge => true
}

import 'classes/*.pp'
import 'nodes/*.pp'
