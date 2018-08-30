package Entity;
import java.util.HashMap;
import java.util.Iterator;

public class Cart {
	private HashMap<Items, Integer> itemMap;
	private double totalPrice;
	
	public Cart() {
		itemMap = new HashMap<Items, Integer>();
		totalPrice = 0.0;
	}
	
	public HashMap<Items, Integer> getGoods() {
		return itemMap;
	}
	public void setGoods(HashMap<Items, Integer> goods) {
		this.itemMap = goods;
	}
	public double getTotalPrice() {
		return totalPrice;
	}
	public void setTotalPrice(double totalPrice) {
		this.totalPrice = totalPrice;
	}
	
	public boolean addItem (Items item, int quantity) {
		if (itemMap.containsKey(item)) {
			itemMap.put(item, itemMap.get(item) + quantity);
		} else {
			itemMap.put(item, quantity);
		}
		calTotalPrice();
		return true;
	}
	
	public boolean removeItem (Items item) {
		itemMap.remove(item);
		calTotalPrice();
		return true;
	}
	
	public double calTotalPrice() {
		double sum = 0;
		Iterator<Items> it = itemMap.keySet().iterator();
		while (it.hasNext()) {
			Items i = it.next();
			sum += i.getPrice()*itemMap.get(i);
		}
		setTotalPrice(sum);
		return getTotalPrice();
	}
}
