package com.fitness.membership_system.model;

import java.util.LinkedList;

public class RenewalQueue {
    private LinkedList<RenewalRequest> queue;

    public RenewalQueue() {
        this.queue = new LinkedList<>();
    }

    public void enqueue(RenewalRequest request) {
        queue.addLast(request);
    }

    public RenewalRequest dequeue() {
        return queue.isEmpty() ? null : queue.removeFirst();
    }

    public RenewalRequest peek() {
        return queue.isEmpty() ? null : queue.getFirst();
    }

    public boolean isEmpty() {
        return queue.isEmpty();
    }

    public LinkedList<RenewalRequest> getQueue() {
        return new LinkedList<>(queue);
    }

    public void updatePriority(String requestId, int newPriority) {
        for (RenewalRequest request : queue) {
            if (request.getRequestId().equals(requestId)) {
                request.setPriority(newPriority);
                break;
            }
        }
    }
}