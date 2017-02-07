require 'observer'

class ParkingLot
  include Observable
  def initialize(slots)
    @slots = slots.to_i
    @vacant_slots = @slots
    @position = 1
    @parking = {}
    i = 1
    while i <= @slots
     @parking[i] = {}
     i+=1
    end
    add_observer(Notifier.new)
    puts "Total no of slots #{slots}"
  end

  def push(*args)
    if @vacant_slots > 0
      @parking[@position] = { color: args[0], reg_no: args[1]}
      changed
      notify_observers(self, @position, "parked at")
      @position+=1
      @vacant_slots-=1
    else
      changed
      notify_observers(self, 0, "parked at")
    end
  end

  def pop(slot)
    @parking[slot] = {}
    changed
    notify_observers(self, slot, "left from")
    @position = slot
    @vacant_slots+=1  
  end
end

class Notifier
 def update(p, slot, msg)
  if slot > 0
    puts msg + " slot" + slot.to_s +  p.instance_variable_get("@parking")[slot].values.join(" ")
  else
    puts "Parking slot is full"
  end
 end
end
