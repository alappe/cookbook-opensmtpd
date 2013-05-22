OpenSMTPD Cookbook
==================

Install and configure OpenSMTPD, the »FREE implementation of the server-side SMTP protocol as defined by RFC 5321, with some additional standard extensions. It allows ordinary machines to exchange e-mails with other systems speaking the SMTP protocol.«

Platform
--------

The following platform families are supported:

* Debian

Requirements
------------

#### recipes
- `git` - opensmtpd needs git to fetch the source code.

Attributes
----------

#### opensmtpd::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['opensmtpd']['git_url']</tt></td>
    <td>String</td>
    <td>repository to build from</td>
    <td><tt>git://github.com/poolpOrg/OpenSMTPD.git</tt></td>
  </tr>
  <tr>
    <td><tt>['opensmtpd']['git_rev']</tt></td>
    <td>String</td>
    <td>Branch or sha to fetch. Defaults to portable for Linux/OS X</td>
    <td><tt>portable</tt></td>
  </tr>
  <tr>
    <td><tt>['opensmtpd']['src_dir']</tt></td>
    <td>String</td>
    <td>Where to store the source and build it</td>
    <td><tt>/usr/local/src/opensmtpd</tt></td>
  </tr>
  <tr>
    <td><tt>['opensmtpd']['prefix']</tt></td>
    <td>String</td>
    <td>`--prefix=` to pass to the configure script</td>
    <td><tt>/usr/local</tt></td>
  </tr>
  <tr>
    <td><tt>['opensmtpd']['config_dir']</tt></td>
    <td>String</td>
    <td>`--sysconfdir=` to pass to the configure script</td>
    <td><tt>/etc</tt></td>
  </tr>
  <tr>
    <td><tt>['opensmtpd']['privsep']['empty_dir']</tt></td>
    <td>String</td>
    <td>Empty directory as home for privsep users (will be created)</td>
    <td><tt>/var/empty</tt></td>
  </tr>
  <tr>
    <td><tt>['opensmtpd']['privsep']['user_shell']</tt></td>
    <td>String</td>
    <td>Shell for privsep users</td>
    <td><tt>/usr/sbin/nologin</tt></td>
  </tr>
  <tr>
    <td><tt>['opensmtpd'['smtpd.conf']['macros']</tt></td>
    <td>Hash</td>
    <td>Key/Value pairs to write into configuration, e.g. `{ 'lan_addr' => '192.168.0.1' }`</td>
    <td><tt>{}</tt></td>
  </tr>
  <tr>
    <td><tt>['opensmtpd'['smtpd.conf']['listen']</tt></td>
    <td>Array</td>
    <td>Array of listen statements to write into configuration</td>
    <td><tt>[ 'on localhost' ]</tt></td>
  </tr>
  <tr>
    <td><tt>['opensmtpd'['smtpd.conf']['accept']</tt></td>
    <td>Array</td>
    <td>Array of accept statements to write into configuration</td>
    <td><tt>[ 'for local alias <aliases> deliver to mbox' ]</tt></td>
  </tr>
  <tr>
    <td><tt>['opensmtpd'['smtpd.conf']['reject']</tt></td>
    <td>Array</td>
    <td>Array of reject statements to write into configuration</td>
    <td><tt>[ ]</tt></td>
  </tr>
  <tr>
    <td><tt>['opensmtpd'['smtpd.conf']['bounce-warn']</tt></td>
    <td>String</td>
    <td>Specify the delays for which temporary failure reports must be generated when messages are stuck in the queue</td>
    <td><tt>4h</tt></td>
  </tr>
  <tr>
    <td><tt>['opensmtpd'['smtpd.conf']['expire']</tt></td>
    <td>String</td>
    <td>Specify how long a message can stay in the queue</td>
    <td><tt>4d</tt></td>
  </tr>
  <tr>
    <td><tt>['opensmtpd'['smtpd.conf']['max-message-size']</tt></td>
    <td>String</td>
    <td>Specify a maximum message size of n bytes. OpenSMTPD uses 35MB if set to `nil`</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['opensmtpd'['smtpd.conf']['tables']</tt></td>
    <td>Hash</td>
    <td>Hash of table statements that specify the path and type of the file as well as the content. If the type is `db`, the recipe also runs `makemap` on them after updating the content. The first key of this hash also serves as the identifier and can be referenced in e.g. `accept` statements like `accept for local alias <aliases> deliver to mbox`</td>
    <td><tt>{ 'aliases' => { 'path' => '/etc/aliases', 'type' => 'db', 'content' => { 'postmaster' => 'root' } } }</tt></td>
  </tr>
</table>

For all the configuration you can do, please read the [manual](http://opensmtpd.org/smtpd.conf.5.html).

Usage
-----
#### opensmtpd::default

Just include `opensmtpd` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[opensmtpd]"
  ]
}
```

Obviously OpenSMTPD may conflict with an installation of another mta, so please remove them before. Also, the defalut configuration above will override your /etc/aliases if you have one, so override `['opensmtpd']['smtpd.conf']['tables']` with `{ }` (or any real needed data) to avoid this.

Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

Authors
-------

* Andreas Lappe

License
-------

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
