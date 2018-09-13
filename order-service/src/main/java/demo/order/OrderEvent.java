package demo.order;

import demo.domain.BaseEntity;
import org.springframework.data.mongodb.core.mapping.Document;

import java.io.Serializable;

@Document
public class OrderEvent extends BaseEntity implements Serializable {

    private static final long serialVersionUID = -8578850018672699516L;
	private String id;
    private OrderEventType type;
    private String orderId;

    public OrderEvent() {
    }

    public OrderEvent(OrderEventType type) {
        this.type = type;
    }

    public OrderEvent(OrderEventType type, String orderId) {
        this.type = type;
        this.orderId = orderId;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public OrderEventType getType() {
        return type;
    }

    public void setType(OrderEventType type) {
        this.type = type;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    @Override
    public String toString() {
        return "OrderEvent{" +
                "id='" + id + '\'' +
                ", type=" + type +
                ", orderId='" + orderId + '\'' +
                "} " + super.toString();
    }
}
