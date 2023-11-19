CREATE OR REPLACE PROCEDURE LPG_TEST.customer_to_customer_transfer (
    in_location_id IN NUMBER,  -- location id from where we want to sell (FG Store ID)
    in_customer_id IN NUMBER,  -- new customer id to whom we want to transfer
    old_customer_id IN NUMBER,  -- old customer id from whom we want to transfer
    out_error_code OUT VARCHAR2,
    out_error_text OUT VARCHAR2
)
IS   
/*
    -- First need to create RIGP Entry with old customer id of those qty at distributor to distributor transfer location
    -- select location dist to dist transfer + Package type receive
    -- Then entry in loan refill tolling receive
    (add record in stock balance table with rate if item is not at that location 33)
    -- Then HOD Approval of that records
    -- After that,put adjust qty in challan ref table of Refill item of those package item (Search by vendor code) {2 (package id) -->12 (refill id), 3 (pkg) --> 13 (refill)}
    -- Then execute this procedure 
*/
    CURSOR c1
    IS
    SELECT loan_rec_no donum,
           lr.creation_date dodate,
           ar.customer_id customer_id_old,
           in_customer_id customer_id,
           lr.creation_date + 3 do_validity_date,
           lr.creation_date a_date,
           null sof_no,
           null sof_dat,
           lri.item_id item_id_old,
           (select fg_item_id from inv_items where item_id = lri.item_id)item_id,
           lr.location_id,
           to_number(ar.customer_type) customer_type,
           lri.received_qty do_qty,
           0 item_rate,
           0 vat,
           1300 s_rate,
           lr.company_id,
           lr.branch_id
    FROM inv_loans_receive lr,
         inv_loan_receive_items lri,
         ar_customers ar
    WHERE lr.loan_rec_id = lri.loan_rec_id
    AND lr.vendor_id = ar.vendor_code
    AND lr.loan_rec_status = 'APPROVED'
    AND lr.location_id = 33
    AND ar.customer_id = old_customer_id
    and lr.loan_rec_id not in (select NVL(dtd_ref,0) from inv_adjs);
    
    l_prev_donum NUMBER := -9999;
    l_prev_cust NUMBER := -9999;
    l_sale_order_id NUMBER;
    l_sale_order_no VARCHAR2(50);
    l_sale_order_item_id NUMBER;
    l_po_id NUMBER;
    l_po_no VARCHAR2(50);
    a NUMBER := 0;
    
    l_delivery_challan_id NUMBER;
    l_delivery_challan_no NUMBER;
    l_dc_dtl_id NUMBER;
    b NUMBER := 0;
    
    l_prev_inv_no NUMBER := -9999;
    
    l_prev_dc_id NUMBER := -9999;
    l_ogp_id NUMBER;
    l_ogp_dtl_id NUMBER;
    c NUMBER := 0;
    
    l_inv_sales_items_id NUMBER;
    l_sales_invoice_id NUMBER;
    l_sales_invoice_no NUMBER;
    l_prev_ogp_id NUMBER := -9999;
    l_ogp_no NUMBER;
    d NUMBER := 0;
    
    l_prev_cust_id NUMBER := -5555;
    
    l_adj_id NUMBER;
    l_adj_no NUMBER;
    
BEGIN  
    FOR m IN c1 LOOP
   
        SELECT NVL(MAX(adj_id),0)+1 
        INTO l_adj_id 
        FROM inv_adjs;
            
        SELECT NVL(MAX(adj_no),0)+1 
        INTO l_adj_no 
        FROM inv_adjs 
        WHERE company_id=m.company_id 
        AND branch_id=m.branch_id;
            
        INSERT INTO inv_adjs (
            adj_id, 
            remarks, 
            created_by, 
            creation_date, 
            last_updated_by, 
            last_update_date, 
            item_id, 
            locator_id, 
            adj_qty, 
            adj_rate, 
            adj_amount, 
            adj_status, 
            approved_by, 
            approval_date, 
            company_id, 
            branch_id, 
            location_id, 
            adj_no,
            dtd_ref
        )
        VALUES (
            l_adj_id,
            'DTD TRANSFER',
            109,
            m.dodate,
            109,
            SYSDATE,
            m.item_id_old,
            NULL,
            -1 * m.do_qty,
            inv_supp.get_current_rate (
                in_company_id   => m.company_id,
                in_branch_id    => m.branch_id,
                in_location_id  => m.location_id,
                in_item_id      => m.item_id_old
            ),
            inv_supp.get_current_rate (
                in_company_id   => m.company_id,
                in_branch_id    => m.branch_id,
                in_location_id  => m.location_id,
                in_item_id      => m.item_id_old
            ) * m.do_qty * -1,
            'APPROVED',
            109,
            SYSDATE,
            m.company_id,
            m.branch_id,
            33,
            l_adj_no,
            m.donum
        );
            
        COMMIT;
        
        SELECT NVL(MAX(adj_id),0)+1 
        INTO l_adj_id 
        FROM inv_adjs;
            
        SELECT NVL(MAX(adj_no),0)+1 
        INTO l_adj_no 
        FROM inv_adjs 
        WHERE company_id=m.company_id 
        AND branch_id=m.branch_id;
            
        INSERT INTO inv_adjs (
            adj_id, 
            remarks, 
            created_by, 
            creation_date, 
            last_updated_by, 
            last_update_date, 
            item_id, 
            locator_id, 
            adj_qty, 
            adj_rate, 
            adj_amount, 
            adj_status, 
            approved_by, 
            approval_date, 
            company_id, 
            branch_id, 
            location_id, 
            adj_no,
            dtd_ref
        )
        VALUES (
            l_adj_id,
            'DTD TRANSFER',
            109,
            m.dodate,
            109,
            SYSDATE,
            m.item_id,
            NULL,
            m.do_qty,
            0,
            0,
            'APPROVED',
            109,
            SYSDATE,
            m.company_id,
            m.branch_id,
            in_location_id,
            l_adj_no,
            m.donum
        );
            
        COMMIT;
        
        IF a = 0 or l_prev_cust <> m.customer_id THEN
    
            SELECT inv_sales_orders_s.NEXTVAL 
            INTO l_sale_order_id
            FROM dual;
            
            SELECT NVL(MAX(po_id),0)+1 
            INTO l_po_id
            FROM inv_sales_orders 
            WHERE company_id=1 
            AND branch_id='01';
            
            l_po_no := '101'|| l_po_id;
        
            INSERT INTO inv_sales_orders (
                sales_order_id, 
                po_no, 
                po_date, 
                customer_id, 
                validity_date, 
                payment_terms, 
                created_by, 
                creation_date, 
                last_update_by, 
                last_update_date, 
                approved_by, 
                approved_date, 
                order_status, 
                po_currency, 
                proforma_inv_no, 
                proforma_inv_date, 
                active, 
                closed_by, 
                closed_date, 
                scn_id, 
                po_id, 
                remarks, 
                mrn_id, 
                company_id, 
                branch_id, 
                location_id, 
                customer_type, 
                delivery_address, 
                sof_no, 
                sof_date,
                mapics_do_no,
                old_customer_id
            )
            VALUES (
                l_sale_order_id,
                l_po_no,
                m.dodate,
                m.customer_id,
                m.do_validity_date,
                'AP',
                121,
                m.dodate,
                121,
                SYSDATE,
                121,
                m.dodate,
                'CLOSED',
                'BDT',
                NULL,
                NULL,
                NULL,
                121,
                m.dodate,
                NULL,
                l_po_id,
                'DTD'||m.donum,
                NULL,
                1,
                '01',
                in_location_id,
                m.customer_type,
                NULL,
                m.sof_no,
                m.sof_dat,
                m.donum,
                M.customer_id_old
            );
            
            COMMIT;
            
            a := 1;
        
        END IF;
        
        SELECT inv_sales_order_items_s.NEXTVAL 
        INTO l_sale_order_item_id
        FROM dual;
       
        INSERT INTO inv_sales_order_items (
            sales_order_item_id, 
            sales_order_id, 
            item_id, 
            qty, 
            rate1, 
            amount, 
            delivered_qty, 
            created_by, 
            creation_date, 
            last_update_by, 
            last_update_date, 
            rate, 
            sales_tax, 
            commission, 
            old_qty, 
            closed, 
            closed_by, 
            closed_date, 
            discount, 
            excise_duty,
            mapic_inv_qty
        )
        VALUES (
            l_sale_order_item_id,
            l_sale_order_id,
            m.item_id,
            m.do_qty,
            m.s_rate,
            m.do_qty * m.item_rate,
            m.do_qty,
            121,
            m.dodate,
            121,
            SYSDATE,
            m.item_rate,
            m.vat,
            NULL,
            NULL,
            'Y',
            121,
            m.dodate,
            NULL,
            NULL,
            null
        );

        COMMIT; 
        
        l_prev_donum := m.donum;
        l_prev_cust  := m.customer_id;
   
    END LOOP;
  
  
 
    FOR n IN (
       SELECT 1,         
              o.po_date ,
              o.customer_id,
              o.location_id,
              o.sales_order_id,
              oi.sales_order_item_id,
              oi.item_id,
              oi.qty ,
              0,
              oi.rate1 ,
              null,
              o.mapics_do_no
        FROM inv_sales_orders o,
            inv_sales_order_items oi
        WHERE o.sales_order_id = oi.sales_order_id
        AND o.remarks = 'DTD'||o.MAPICS_DO_NO
        AND o.MAPICS_DO_NO NOT IN (SELECT NVL(old_invoice_no,0) FROM INV_DELIVERY_CHALLANS)
        ORDER BY o.customer_id
    ) LOOP
   
        IF l_prev_cust <> n.customer_id OR b = 0 THEN

           SELECT  inv_challan_id_s.NEXTVAL 
           INTO l_delivery_challan_id  
           FROM dual;
           
           SELECT NVL(MAX(challan_no),0)+1 
           INTO l_delivery_challan_no
           FROM inv_delivery_challans 
           WHERE company_id=1
           AND branch_id='01';

           INSERT INTO inv_delivery_challans (
                challan_id, 
                challan_no, 
                challan_date, 
                customer_id, 
                created_by, 
                creation_date, 
                last_updated_by, 
                last_update_date, 
                approved_by, 
                approved_date, 
                delivery_status, 
                remarks, 
                batch_no, 
                dc_jit, 
                export_date, 
                discharge_port, 
                gross_weight, 
                shipment_type, 
                user_ip, 
                company_id, 
                branch_id, 
                location_id, 
                gl_voucher_id, 
                chk_export,
                old_invoice_no
           )
           VALUES (
                l_delivery_challan_id,
                l_delivery_challan_no,
                n.po_date,
                n.customer_id,  
                121,
                n.po_date,
                121,
                SYSDATE,
                121,
                n.po_date,
                'INVOICED',
                'DTD'||n.mapics_do_no,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                1,
                '01',
                n.location_id,
                NULL,
                NULL,
                n.mapics_do_no
           );
           
           b := 1;
           
        END IF;    
   
        SELECT  inv_challan_item_id_s.nextval 
        INTO l_dc_dtl_id 
        FROM dual;
       
        INSERT INTO inv_delivery_challan_items (
            challan_item_id, 
            challan_id, 
            item_id, 
            qty, 
            sale_order_id, 
            sale_order_item_id, 
            created_by, 
            creation_date, 
            last_updated_by, 
            last_update_date, 
            rate, 
            amount, 
            sale_rate, 
            sale_amount, 
            packing_information, 
            no_cartons, 
            rate1, 
            amount1, 
            vat_percent, 
            vat_amount, 
            avg_rate, 
            local_sale_rate,
            issue_ref
        )
        VALUES (
            l_dc_dtl_id ,
            l_delivery_challan_id,
            n.item_id,
            n.qty,  
            n.sales_order_id,
            n.sales_order_item_id,
            121,
            n.po_date,
            121,
            SYSDATE,
            0,
            0 ,
            NULL,
            NULL,
            NULL,
            NULL,
            n.rate1,
            n.qty * n.rate1,
            7,
            NULL,
            NULL,
            NULL,
            null
        );
        
        COMMIT;

        l_prev_cust := n.customer_id;
        
    END LOOP;     
 
    FOR p IN (
        SELECT dc.challan_id ,
               dc.challan_date,
               dc.location_id,
               dc.customer_id,
               dci.item_id,
               dci.sale_order_item_id,
               dci.sale_order_id,
               dci.qty,
               dci.rate,
               dci.challan_item_id,
               dc.old_invoice_no
        FROM inv_delivery_challans dc,
             inv_delivery_challan_items dci
        WHERE dc.challan_id = dci.challan_id
        AND dc.remarks = 'DTD'||dc.old_invoice_no
        AND dc.OLD_INVOICE_NO NOT IN (SELECT NVL(old_invoice_no,0) FROM INV_SALES_OGPS)
        ORDER BY dc.challan_id
    ) LOOP 
        
        IF l_prev_dc_id <> p.challan_id OR c = 0 THEN
      
            write_dc_reference (
                challan        => p.challan_id , 
                in_location_id => p.location_id
           );
       
            SELECT NVL(MAX(sales_ogp_id),0)+1 
            INTO l_ogp_id
            FROM inv_sales_ogps;
            
            SELECT NVL(MAX(sales_ogp_id),0)+1 
            INTO l_ogp_no
            FROM inv_sales_ogps
            WHERE company_id = 1 
            AND branch_id = '01';
        
            INSERT INTO inv_sales_ogps (
                sales_ogp_id, 
                customer_id, 
                vehicle_type, 
                vehicle_no, 
                driver_name, 
                challan_id, 
                created_by, 
                creation_date, 
                last_updated_by, 
                last_update_date, 
                trans_comp, 
                remarks, 
                out, 
                out_date, 
                out_by, 
                ogp_status, 
                builty_no, 
                mode_of_transport, 
                company_id, 
                branch_id, 
                location_id, 
                driver_phone,
                old_invoice_no,
                sale_ogp_no
            )
            VALUES (
                l_ogp_id,
                p.customer_id,
                NULL,
                NULL,  
                NULL,
                p.challan_id,
                121,
                p.challan_date,
                121,
                SYSDATE,
                NULL,
                'DTD'||p.old_invoice_no,
                'Y',
                p.challan_date,
                121,
                'OUT',
                NULL,
                NULL,
                1,
                '01',
                p.location_id,
                NULL,
                p.old_invoice_no,
                l_ogp_no
            );
           
            COMMIT;
            c := 1;
        END IF;
        
        SELECT INV_SALES_OGP_ITEMS_ID_S.NEXTVAL 
        INTO l_ogp_dtl_id
        FROM DUAL;

           
        INSERT INTO inv_sales_ogp_items (
            item_id, 
            qty, 
            sales_ogp_id, 
            created_by, 
            creation_date, 
            last_updated_by, 
            last_update_date, 
            sale_order_item_id, 
            challan_item_id, 
            sale_order_id, 
            inv_sales_ogp_items_id
        )
        VALUES (
            p.item_id,
            p.qty,
            l_ogp_id,
            121,  
            p.challan_date,
            121,
            SYSDATE,
            p.sale_order_item_id,
            p.challan_item_id,
            p.sale_order_id,
            l_ogp_dtl_id
        );
        
        l_prev_dc_id := p.challan_id;
   
        COMMIT;
        
    END LOOP;

    FOR r IN (
        SELECT o.sales_ogp_id,
               o.customer_id,
               o.challan_id,
               o.out_date,
               o.location_id,
               c.challan_no,
               oi.item_id,
               oi.qty,
               ci.RATE1 rate,
               ci.sale_order_item_id,
               ci.sale_order_id,
               o.old_invoice_no
        FROM inv_sales_ogps o,
             inv_sales_ogp_items oi,
             inv_delivery_challans c,
             inv_delivery_challan_items ci
        WHERE o.sales_ogp_id = oi.sales_ogp_id
        AND o.challan_id = c.challan_id
        AND c.challan_id = ci.challan_id
        AND ci.challan_item_id = oi.challan_item_id
        AND o.remarks = 'DTD'||o.old_invoice_no
        AND o.OLD_INVOICE_NO not in (select nvl(old_invoice_no,0) from inv_sales_invoices)
        ORDER BY o.sales_ogp_id
    ) LOOP 
        
        IF r.sales_ogp_id <> l_prev_ogp_id OR d = 0 THEN
    
            SELECT NVL(MAX(sales_invoice_id),0)+1 
            INTO l_sales_invoice_id 
            FROM inv_sales_invoices;
            
            SELECT NVL(MAX(sales_invoice_id),0)+1 
            INTO l_sales_invoice_no 
            FROM inv_sales_invoices
            WHERE company_id = 1
            AND branch_id = '01';
       
            INSERT INTO inv_sales_invoices (
                sales_invoice_id, 
                customer_id, 
                challan_id, 
                created_by, 
                creation_date, 
                last_updated_by, 
                last_update_date, 
                sales_ogp_id, 
                remarks, 
                invoice_amount, 
                sales_tax_amount, 
                total_invoice_amount, 
                invoice_adjusted, 
                invoice_balance, 
                st_account_id, 
                receivable_account_id, 
                invoice_date, 
                gl_voucher_id, 
                excise_duty, 
                invoice_no, 
                parent_invoice_id, 
                ed_percent, 
                jit_inv, 
                exchange_rate, 
                currency_inv, 
                incometax_wh, 
                bl_date, 
                add_sales_tax_amnt, 
                extra_sales_tax_amount, 
                further_sales_tax_amount, 
                invoice_status, 
                incom_tax_amount, 
                company_id, 
                branch_id, 
                location_id,
                old_invoice_no
            )
            VALUES (
                l_sales_invoice_id,
                r.customer_id,
                r.challan_id,
                121,
                r.out_date,    
                121,
                SYSDATE,
                r.sales_ogp_id,
                'Distributor to Distributor Transfer Invoice',
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                r.out_date,
                NULL,
                NULL,
                l_sales_invoice_no,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                'PREPARED',
                NULL,
                1,
                '01',
                r.location_id,
                r.old_invoice_no
            );
           
            COMMIT;
            
            d := 1;
        
        END IF;
            
        SELECT inv_sales_invoice_items_id_s.NEXTVAL 
        INTO l_inv_sales_items_id
        FROM DUAL;
       
        INSERT INTO inv_sales_invoice_items (
            sales_invoice_id, 
            item_id, 
            qty, 
            sale_order_id, 
            sale_order_item_id, 
            created_by, 
            creation_date, 
            last_updated_by, 
            last_update_date, 
            rate, 
            amount, 
            sales_tax_percent, 
            excise_duty, 
            debit_qty, 
            debit_amount, 
            account_id, 
            inv_sales_invoice_items_id, 
            extra_sales_tax_percent, 
            further_sales_tax_percent, 
            incom_tax_percent, 
            security_rate, 
            security_amount
        )
        VALUES (
            l_sales_invoice_id,
            r.item_id,
            r.qty,
            r.sale_order_id,
            r.sale_order_item_id,
            121,
            r.out_date,
            121,
            SYSDATE,
            0,
            r.qty * 0,
            7,
            NULL,
            NULL,
            NULL,
            NULL,
            l_inv_sales_items_id,
            NULL,
            NULL,
            NULL,
            r.rate,
            NVL(r.qty,0) * NVL(r.rate,0)
        );
       
        COMMIT;
        
        l_prev_ogp_id := r.sales_ogp_id ;
    
    END LOOP;
END;
/
