#
#            Automate Method
#
# Copyright (C) 2016, Christian Jung
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

begin
    $evm.log("info", "EVM Automate Method Started")
  
    # Dump all of root's attributes to the log
    $evm.root.attributes.sort.each { |k, v| $evm.log("info", "Root:<$evm.root> Attribute - #{k}: #{v}")}
  
    nodename = $evm.root["dialog_nodename"]
    
    nodelist = nodename.join(" ")
    random = (0...8).map { (65 + rand(26)).chr }.join    
    $evm.log("info", "su - clouduser -c '/home/clouduser/delete_host_wrapper.sh #{nodelist}' &> /tmp/delete-#{random}.log")
    rc=system("su - clouduser -c '/home/clouduser/delete_host_wrapper.sh #{nodelist}' &> /tmp/delete-#{random}.log")
    $evm.log("info", "Return Code: #{rc.inspect}")    
    if rc != true
        exit MIQ_ABORT
    end 

    #
    # Exit method
    #
    $evm.log("info", "EVM Automate Method Ended")
    exit MIQ_OK
  
    #
    # Set Ruby rescue behavior
    #
rescue => err
    $evm.log("error", "[#{err}]\n#{err.backtrace.join("\n")}")
    exit MIQ_ABORT
end
  