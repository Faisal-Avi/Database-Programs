DROP TRIGGER TRG_INV_GRN_ITEMS;

CREATE OR REPLACE TRIGGER TRG_INV_GRN_ITEMS 
    AFTER DELETE OR INSERT OR UPDATE ON LPG_TEST.INV_GRN_ITEMS 
    REFERENCING NEW AS NEW OLD AS OLD
    FOR EACH ROW
DECLARE
    CURSOR cur_grn(p_grn_id NUMBER)
    IS 
    SELECT company_id,
           branch_id,
           location_id
    FROM inv_grns
    WHERE grn_id = p_grn_id;
    l_company_id NUMBER;
    l_branch_id VARCHAR2(10);
    l_location_id NUMBER;
BEGIN
    
   OPEN cur_grn(NVL(:NEW.grn_id,:OLD.grn_id));
       FETCH cur_grn INTO l_company_id, l_branch_id, l_location_id ;
   CLOSE cur_grn;    

    IF INSERTING THEN
    
        IF NVL (:NEW.received_qty, 0) > 0 THEN
            inv_supp.upd_stock_balance_trg (
                in_company_id   => l_company_id,
                in_branch_id    => l_branch_id,
                in_location_id  => l_location_id,
                in_item_id      => :NEW.item_id,
                in_qty          => :NEW.received_qty,
                in_amount       => :NEW.received_qty * :NEW.rate,
                in_user_id      => :NEW.created_by
            );
        END IF;
          
    ELSIF UPDATING THEN  

        IF NVL (:OLD.received_qty, 0) > 0 THEN
            inv_supp.upd_stock_balance_trg (
                in_company_id   => l_company_id,
                in_branch_id    => l_branch_id,
                in_location_id  => l_location_id,
                in_item_id      => :OLD.item_id,
                in_qty          => -1 * :OLD.received_qty,
                in_amount       => -1 * :OLD.received_qty * :OLD.rate,
                in_user_id      => :OLD.created_by
            );
        END IF;
            
        IF NVL (:NEW.received_qty, 0) > 0 THEN
            inv_supp.upd_stock_balance_trg (
                in_company_id   => l_company_id,
                in_branch_id    => l_branch_id,
                in_location_id  => l_location_id,
                in_item_id      => :NEW.item_id,
                in_qty          => :NEW.received_qty,
                in_amount       => :NEW.received_qty * :NEW.rate,
                in_user_id      => :NEW.created_by
            );
        END IF;
        
    ELSIF DELETING THEN
       
          IF NVL (:OLD.received_qty, 0) > 0 THEN
              inv_supp.upd_stock_balance_trg (
                    in_company_id   => l_company_id,
                    in_branch_id    => l_branch_id,
                    in_location_id  => l_location_id,
                    in_item_id      => :OLD.item_id,
                    in_qty          => -1 * :OLD.received_qty,
                    in_amount       => -1 * :OLD.received_qty * :OLD.rate,
                    in_user_id      => :OLD.created_by
                );
          END IF;  
          
    END IF;
    
EXCEPTION
   WHEN OTHERS
   THEN NULL;
END trg_inv_grn_items;
/
