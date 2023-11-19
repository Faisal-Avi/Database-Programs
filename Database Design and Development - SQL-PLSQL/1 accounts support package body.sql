CREATE OR REPLACE PACKAGE acc_supp
IS  
    FUNCTION get_adv_chk_draft_value (
        in_invoice_id    IN     NUMBER
    ) RETURN NUMBER;

    FUNCTION check_adv_payment_type (
        in_payment_term  IN     VARCHAR2
    ) RETURN VARCHAR2;
    
    FUNCTION get_invoice_avd_chk_amt (
        in_invoice_id    IN     NUMBER
    ) RETURN NUMBER;
    
    PROCEDURE upd_ar_adv_cheque (
        in_invoice_id    IN     NUMBER,
        out_error_code   OUT    VARCHAR2,
        out_error_text   OUT    VARCHAR2
    );
    
    PROCEDURE upd_ar_adv_cheque (
        in_cheque_no     IN     VARCHAR2,
        in_amount        IN     NUMBER
    );
    
    FUNCTION check_advance_cheque (
        in_dc_id         IN     NUMBER
    ) RETURN VARCHAR2;
    
    /*
     -- This voucher is generated when GRN 
    */
    
    PROCEDURE inv_grn_expense_voucher (
        in_grn_id        IN     NUMBER,
        in_user_id       IN     NUMBER,
        in_company_id    IN     NUMBER,
        in_branch_id     IN     VARCHAR2
    );
    
    PROCEDURE inv_grn_voucher (
        g_id             IN     NUMBER,
        user_id          IN     NUMBER,
        in_company_id    IN     NUMBER,
        in_branch_id     IN     VARCHAR2,
        out_error_code   OUT    VARCHAR2,
        out_error_text   OUT    VARCHAR2
    );
    
    /*
     -- During Invoice Matching
    */
    
    PROCEDURE ap_invoice_expense_transfer (
        inv_id           IN     NUMBER,
        user_id          IN     NUMBER,
        gl_v_id          IN     NUMBER,
        in_company_id    IN     NUMBER,
        in_branch_id     IN     VARCHAR2
    );
    
    PROCEDURE ap_invoice_transfer (
        inv_id           IN     NUMBER,
        user_id          IN     NUMBER,
        gl_v_id          IN     NUMBER,
        in_company_id    IN     NUMBER,
        in_branch_id     IN     VARCHAR2,
        out_error_code   OUT    VARCHAR2,
        out_error_text   OUT    VARCHAR2
    );
    
    /*
     -- During Payment
    */
    
    FUNCTION gl_add_voucher (
        x_voucher_type          VARCHAR2,
        x_voucher_date          DATE,
        x_description           VARCHAR2,
        x_created_by            NUMBER,
        x_creation_date         DATE,
        x_approved_by           NUMBER,
        x_status                VARCHAR2,
        x_company_id            NUMBER,
        x_branch_id             VARCHAR2,
        x_module                VARCHAR2,
        x_module_doc            VARCHAR2,
        x_module_doc_id         NUMBER,
        x_reference_no          VARCHAR2,
        x_reference_date        DATE,
        x_paid_amount           NUMBER
    ) RETURN NUMBER;
    
    PROCEDURE ap_payment_transfer (
        pay_id           IN     NUMBER,
        user_id          IN     NUMBER,
        gl_v_id          IN     NUMBER,
        in_company_id    IN     NUMBER,
        in_branch_id     IN     VARCHAR2,
        out_error_code   OUT    VARCHAR2,
        out_error_text   OUT    VARCHAR2
    );
    
    
    /*
    -- Consumption voucher during Delivery Challan
    */
    
    PROCEDURE ap_delivery_challan_transfer (
        in_dc_id         IN     NUMBER,
        in_user_id       IN     NUMBER,
        in_company_id    IN     NUMBER,
        in_branch_id     IN     VARCHAR2,
        out_error_code   OUT    VARCHAR2,
        out_error_text   OUT    VARCHAR2
    );
    
    /*
    -- During Sale Invoice 
    */
    
    PROCEDURE ar_invoice_transfer (
        in_inv_id        IN     NUMBER,
        in_user_id       IN     NUMBER,
        in_gl_v_id       IN     NUMBER,
        in_company_id    IN     NUMBER,
        in_branch_id     IN     VARCHAR2,
        out_error_code   OUT    VARCHAR2,
        out_error_text   OUT    VARCHAR2
    );
    
    /*
    --  voucher will be generated when invoice amount has a security deposite part
    */
    
    PROCEDURE ar_invoice_security_deposite (
        in_inv_id        IN     NUMBER,
        in_user_id       IN     NUMBER,
        in_gl_v_id       IN     NUMBER,
        in_company_id    IN     NUMBER,
        in_branch_id     IN     VARCHAR2,
        out_error_code   OUT    VARCHAR2,
        out_error_text   OUT    VARCHAR2
    );
    
    /*
    -- During AR Receipt
    */
    
    PROCEDURE ar_cheque_transfer (
        rec_id           IN     NUMBER,
        user_id          IN     NUMBER,
        gl_v_id          IN     NUMBER,
        in_company_id    IN     NUMBER,
        in_branch_id     IN     VARCHAR2,
        out_error_code   OUT    VARCHAR2,
        out_error_text   OUT    VARCHAR2
    );
    
    /*
    -- During DO Approval Advance Payment Voucher will be generated
    */
    
    PROCEDURE ar_do_transfer (
        do_id            IN     NUMBER,
        user_id          IN     NUMBER,
        gl_v_id          IN     NUMBER,
        in_company_id    IN     NUMBER,
        in_branch_id     IN     VARCHAR2,
        out_error_code   OUT    VARCHAR2,
        out_error_text   OUT    VARCHAR2
    );
    
    PROCEDURE ar_do_bank_charge_trn (
        do_id            IN     NUMBER,
        user_id          IN     NUMBER,
        gl_v_id          IN     NUMBER,
        in_company_id    IN     NUMBER,
        in_branch_id     IN     VARCHAR2,
        out_error_code   OUT    VARCHAR2,
        out_error_text   OUT    VARCHAR2
    );
    
    FUNCTION get_costing_exchange_rate (
        in_po_id         IN     NUMBER
    ) RETURN NUMBER;
    
    FUNCTION get_po_exchange_rate (
        in_po_id         IN     NUMBER
    ) RETURN NUMBER;
    
    FUNCTION po_exch_rate_from_inv (
        in_invoice_id    IN     NUMBER
    ) RETURN NUMBER;
    
    FUNCTION get_voucher_no (
        v_date           IN     DATE, 
        v_type           IN     VARCHAR2, 
        p_company               NUMBER, 
        p_branch                VARCHAR2
    ) RETURN NUMBER;
    
    FUNCTION check_export_in_dc (
        in_dc_id         IN     NUMBER
    ) RETURN VARCHAR2;
    
    FUNCTION get_invoice_account_id (
        in_dc_id         IN     NUMBER,
        in_item_id       IN     NUMBER
    ) RETURN NUMBER;
    
    FUNCTION get_trial_balance (
        in_pnl_mst_id    IN     NUMBER,
        in_month_year    IN     VARCHAR2,
        in_record_level  IN     NUMBER,
        in_company_id    IN     NUMBER,
        in_branch_id     IN     VARCHAR2  
    ) RETURN NUMBER;
     
    FUNCTION get_fiscal_year_start_date (
        in_to_date       IN     DATE
    ) RETURN DATE;
    
    FUNCTION get_yearly_trial_balance (
        in_pnl_mst_id    IN     NUMBER,
        in_end_date      IN     DATE,
        in_record_level  IN     NUMBER,
        in_company_id    IN     NUMBER,
        in_branch_id     IN     VARCHAR2
    ) RETURN NUMBER;
    
    
    
    PROCEDURE ins_gl_profit_loss_data (
        in_start_date    IN     DATE,
        in_end_date      IN     DATE,
        in_company_id    IN     NUMBER,
        in_branch_id     IN     VARCHAR2
    );
    
    
    PROCEDURE populate_gl_profit_loss;
    
    
    FUNCTION get_net_sales_cfy (
        in_end_date      IN     DATE,
        in_company_id    IN     NUMBER,
        in_branch_id     IN     VARCHAR2
    ) RETURN NUMBER;
    
    FUNCTION get_gross_sales_cfy (
        in_end_date      IN     DATE,
        in_company_id    IN     NUMBER,
        in_branch_id     IN     VARCHAR2
    ) RETURN NUMBER;
    
    FUNCTION get_profit_b4_interest_cfy (
        in_end_date      IN     DATE,
        in_company_id    IN     NUMBER,
        in_branch_id     IN     VARCHAR2
    ) RETURN NUMBER;
    
    FUNCTION get_profit_b4_dep_cfy (
        in_end_date      IN     DATE,
        in_company_id    IN     NUMBER,
        in_branch_id     IN     VARCHAR2
    ) RETURN NUMBER;
    
    FUNCTION get_profit_b4_inctx_cfy (
        in_end_date      IN     DATE,
        in_company_id    IN     NUMBER,
        in_branch_id     IN     VARCHAR2
    ) RETURN NUMBER;
    
    FUNCTION get_profit_after_inctx_cfy (
        in_end_date      IN     DATE,
        in_company_id    IN     NUMBER,
        in_branch_id     IN     VARCHAR2
    ) RETURN NUMBER;
    
    
    FUNCTION get_net_sales (
        in_start_date    IN     DATE,
        in_end_date      IN     DATE,
        in_company_id    IN     NUMBER,
        in_branch_id     IN     VARCHAR2
    ) RETURN NUMBER;
    
    FUNCTION get_gross_profit (
        in_start_date    IN     DATE,
        in_end_date      IN     DATE,
        in_company_id    IN     NUMBER,
        in_branch_id     IN     VARCHAR2
    ) RETURN NUMBER;
    
    
    FUNCTION get_profit_before_itd (
        in_start_date    IN     DATE,
        in_end_date      IN     DATE,
        in_company_id    IN     NUMBER,
        in_branch_id     IN     VARCHAR2
    ) RETURN NUMBER;
    
    FUNCTION get_profit_before_di (
        in_start_date    IN     DATE,
        in_end_date      IN     DATE,
        in_company_id    IN     NUMBER,
        in_branch_id     IN     VARCHAR2
    ) RETURN NUMBER;
    
    FUNCTION get_profit_before_it (
        in_start_date    IN     DATE,
        in_end_date      IN     DATE,
        in_company_id    IN     NUMBER,
        in_branch_id     IN     VARCHAR2
    ) RETURN NUMBER;
    
    
    FUNCTION get_profit_after_it (
        in_start_date    IN     DATE,
        in_end_date      IN     DATE,
        in_company_id    IN     NUMBER,
        in_branch_id     IN     VARCHAR2
    ) RETURN NUMBER;
    
    FUNCTION ebitda_usd_exchange_rate 
    RETURN NUMBER;
     
    FUNCTION get_ebitda_mt_qty (
        in_start_date    IN     DATE,
        in_end_date      IN     DATE
    ) RETURN NUMBER;
    
END acc_supp;
/

-------------------------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE BODY acc_supp
IS
    /*
    -- This function is for getting the advance cheque values in receipt but not yet approved
    */        

    FUNCTION get_adv_chk_draft_value (
        in_invoice_id    IN     NUMBER
    ) RETURN NUMBER
    IS
        CURSOR c1
        IS
        SELECT SUM(NVL(d.receipt_amount,0)) 
        FROM ar_receipts m,
             ar_receipt_invoices d
        WHERE m.receipt_id = d.receipt_id
        AND d.invoice_id = in_invoice_id
        AND d.cheque_no IS NOT NULL
        AND m.receipt_status = 'PREPARED';
        
        l_draft_amount NUMBER;
    BEGIN
        OPEN c1;
            FETCH c1 INTO l_draft_amount;
        CLOSE c1;
        RETURN NVL(l_draft_amount,0);
    EXCEPTION
        WHEN OTHERS THEN
        RETURN 0;
    END;

    /*
    -- This function is for checking either the payment term is advance cheque type or not
    */

    FUNCTION check_adv_payment_type (
        in_payment_term  IN     VARCHAR2
    ) RETURN VARCHAR2
    IS
        CURSOR c1
        IS
        SELECT NVL(segment3, 'N') ptt
        FROM data_values
        WHERE value_set_id = 8
        AND value_set_value = in_payment_term;
        l_payment_term_type VARCHAR2(10);
    BEGIN
        OPEN c1;
            FETCH c1 INTO l_payment_term_type ;
        CLOSE c1;
        RETURN l_payment_term_type;
    EXCEPTION
        WHEN OTHERS THEN
        RETURN 'N';
    END;
    
    /*
    -- This function is for getting total advance cheque amount for a invoice
    */

    FUNCTION get_invoice_avd_chk_amt (
        in_invoice_id    IN     NUMBER
    ) RETURN NUMBER
    IS
        CURSOR c1
        IS
        SELECT SUM(ac.balance_amount)
        FROM ar_advance_cheque ac
        WHERE ac.sale_order_id IN (
                                    SELECT sales_order_id
                                    FROM inv_sales_orders so
                                    WHERE so.sales_order_id IN (SELECT DISTINCT sii.sale_order_id
                                                                FROM inv_sales_invoice_items sii
                                                                WHERE sii.sales_invoice_id = in_invoice_id)
                                    AND check_adv_payment_type(so.payment_terms) = 'Y');
        l_total_cheque_amount NUMBER := 0;
    BEGIN
        OPEN c1;
            FETCH c1 INTO l_total_cheque_amount;
        CLOSE c1;
        
        RETURN l_total_cheque_amount;
    EXCEPTION
        WHEN OTHERS THEN
        RETURN 0;
    END;

    /*
    -- This procedure is created for update advance cheque receipt amount
    */
    
    PROCEDURE upd_ar_adv_cheque (
        in_invoice_id    IN     NUMBER,
        out_error_code   OUT    VARCHAR2,
        out_error_text   OUT    VARCHAR2
    )
    IS
        CURSOR so_dc_ck
        IS
        SELECT DISTINCT so.sales_order_id,
               dc.challan_id,
               ri.cheque_no,
               ri.receipt_amount
        FROM inv_sales_orders so,
             inv_delivery_challans dc,
             inv_delivery_challan_items dci,
             inv_sales_invoices si,
             ar_receipts ar,
             ar_receipt_invoices ri
        WHERE so.sales_order_id = dci.sale_order_id
        AND dc.challan_id = dci.challan_id
        AND dci.challan_id = si.challan_id
        AND si.sales_invoice_id = ri.invoice_id
        AND ar.receipt_id = ri.receipt_id
        AND si.sales_invoice_id = in_invoice_id
        AND so.payment_terms = 'AP';
    BEGIN
        FOR i IN so_dc_ck LOOP
            upd_ar_adv_cheque (
                in_cheque_no     => i.cheque_no,
                in_amount        => i.receipt_amount
            );
        END LOOP;
    EXCEPTION
        WHEN OTHERS THEN 
        out_error_code := SQLCODE;
        out_error_text := SQLERRM;
    END;
    
    
    PROCEDURE upd_ar_adv_cheque (
        in_cheque_no     IN     VARCHAR2,
        in_amount        IN     NUMBER
    )
    IS
    BEGIN
        UPDATE ar_advance_cheque
        SET receipt_amount = NVL(receipt_amount,0) + in_amount,
            balance_amount = NVL(balance_amount,0) - in_amount
        WHERE cheque_no = in_cheque_no;
        
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        NULL;
    END;
    
    /*
    -- This function is for checking that if a Delivery challan related sale order 
       payment term is Advanced cheque type or not. Checking Segment 3 = 'Y'
    */
    
    FUNCTION check_advance_cheque (
        in_dc_id         IN     NUMBER
    ) RETURN VARCHAR2
    IS
        CURSOR c1
        IS
        SELECT sale_order_id
        FROM inv_delivery_challan_items
        WHERE challan_id = in_dc_id;
        
        l_cnt NUMBER := 0;
        l_adv_cheque_type VARCHAR2(50);
        l_cnt_not_entered_data NUMBER := 0;
        
    BEGIN
        FOR m IN c1 LOOP
            SELECT NVL(segment3,'N')
            INTO l_adv_cheque_type
            FROM data_values
            WHERE value_set_id = 8
            AND value_set_value = (SELECT payment_terms
                                   FROM inv_sales_orders
                                   WHERE sales_order_id = m.sale_order_id);
            
            IF l_adv_cheque_type = 'Y' THEN
                SELECT COUNT(*)
                INTO l_cnt
                FROM ar_advance_cheque
                WHERE sale_order_id = m.sale_order_id
                AND delivery_challan_id = in_dc_id;
                
                IF l_cnt = 0 THEN
                    l_cnt_not_entered_data := l_cnt_not_entered_data + 1;
                END IF;
            END IF;
            
            l_cnt := 0;

        END LOOP;
        
        IF l_cnt_not_entered_data > 0 THEN
            RETURN 'STOP';
        ELSE
            RETURN 'OK';
        END IF;
    EXCEPTION 
        WHEN OTHERS THEN
        RETURN 'STOP';
    END;
    
    /*
    -- This voucher is generated for the expense part in costing during GRN
    */
    
    
    PROCEDURE inv_grn_expense_voucher (
        in_grn_id        IN     NUMBER,
        in_user_id       IN     NUMBER,
        in_company_id    IN     NUMBER,
        in_branch_id     IN     VARCHAR2
    )
    IS
        branch             VARCHAR2(2) := in_branch_id ;
        company            NUMBER := in_company_id;
        v_voucher_id       NUMBER;
        v_voucher_no       NUMBER;
        acc_date           DATE := SYSDATE;
    BEGIN
        SELECT TRUNC(creation_date)
        INTO acc_date 
        FROM inv_grns 
        WHERE grn_id = in_grn_id;
        
        SELECT gl_voucher_id_s.NEXTVAL  
        INTO v_voucher_id    
        FROM dual;

        v_voucher_no:= get_voucher_no (acc_date, 'JV', company, branch);
        ---******************** This section is for only raw material costing
 
        INSERT INTO gl_vouchers (
            voucher_id, 
            voucher_type, 
            voucher_no, 
            voucher_date,
            description, 
            created_by, 
            creation_date,
            last_updated_by, 
            last_updated_date, 
            status,
            approved_by, 
            approval_date, 
            posted_by, 
            posting_date, 
            module,
            module_doc, 
            module_doc_id, 
            company_id, 
            branch_id
        )
        VALUES (
            v_voucher_id, 
            'JV', 
            v_voucher_no, 
            acc_date,
            'ENTRY against GRN ID ' || in_grn_id, 
            in_user_id, 
            SYSDATE,
            in_user_id, 
            SYSDATE, 
            'PREPARED',
            NULL, 
            NULL, 
            NULL, 
            NULL, 
            'AP',
            'GRN', 
            in_grn_id, 
            company, 
            branch
        );
        
        INSERT INTO gl_voucher_accounts (
            voucher_account_id, 
            voucher_id, 
            account_id, 
            debit, 
            credit,
            naration, 
            created_by, 
            creation_date, 
            last_updated_by,
            last_update_date, 
            reference_id,
            sub_account_code_id
        )
        SELECT gl_voucher_account_id_s.NEXTVAL,
               v_voucher_id, 
               v.account_id, 
               v.dr, 
               v.cr,
               v.naration, 
               in_user_id, 
               SYSDATE, 
               in_user_id, 
               SYSDATE, 
               v.grn_id,
               sub_account_code
        FROM ap_grn_expense_transfer_v v
        WHERE v.grn_id = in_grn_id;

        UPDATE inv_grns 
        SET expense_voucher_id = v_voucher_id
        WHERE grn_id = in_grn_id;
        
        COMMIT;
    END;

    /*
    -- This procedure is created for auto generation of voucher during grn ----  AP
    */
    
    PROCEDURE inv_grn_voucher (
        g_id             IN     NUMBER,
        user_id          IN     NUMBER,
        in_company_id    IN     NUMBER,
        in_branch_id     IN     VARCHAR2,
        out_error_code   OUT    VARCHAR2,
        out_error_text   OUT    VARCHAR2
    )
    IS
        branch             VARCHAR2(2) := in_branch_id ;
        company            NUMBER := in_company_id;
        v_voucher_id       NUMBER;
        v_voucher_no       NUMBER;
        acc_date           DATE         := SYSDATE;
    BEGIN
        SELECT TRUNC(creation_date) 
        INTO acc_date 
        FROM inv_grns 
        WHERE grn_id = g_id;
        
        SELECT gl_voucher_id_s.NEXTVAL  
        INTO v_voucher_id    
        FROM dual;

        v_voucher_no:= get_voucher_no (acc_date, 'JVP', company, branch);
        
        ---******************** This section is for only raw material costing
 
        INSERT INTO gl_vouchers (
            voucher_id, 
            voucher_type, 
            voucher_no, 
            voucher_date,
            description, 
            created_by, 
            creation_date,
            last_updated_by, 
            last_updated_date, 
            status,
            approved_by, 
            approval_date, 
            posted_by, 
            posting_date, 
            module,
            module_doc, 
            module_doc_id, 
            company_id, 
            branch_id
        )
        VALUES (
            v_voucher_id, 
            'JVP', 
            v_voucher_no, 
            acc_date,
            'ENTRY against GRN ID ' || g_id, 
            user_id, 
            SYSDATE,
            user_id, 
            SYSDATE, 
            'PREPARED',
            NULL, 
            NULL, 
            NULL, 
            NULL, 
            'AP',
            'GRN', 
            g_id, 
            company, 
            branch
        );
               
   
   
        INSERT INTO gl_voucher_accounts (
            voucher_account_id, 
            voucher_id, 
            account_id, 
            debit, 
            credit,
            naration, 
            created_by, 
            creation_date, 
            last_updated_by,
            last_update_date, 
            reference_id,
            sub_account_code_id
        )
        SELECT gl_voucher_account_id_s.NEXTVAL,
               v_voucher_id, 
               v.account_id, 
               v.dr, 
               v.cr,
               v.naration, 
               user_id, 
               SYSDATE, 
               user_id, 
               SYSDATE, 
               v.grn_id,
               sub_account_code
        FROM inv_grn_transfer_v v
        WHERE v.grn_id = g_id;

        UPDATE inv_grns 
        SET voucher_id = v_voucher_id
        WHERE grn_id = g_id;
        
        COMMIT;
        
        --**************************** --> This section is for others expenses during grn
        
        acc_supp.inv_grn_expense_voucher (
            in_grn_id        => g_id,
            in_user_id       => user_id,
            in_company_id    => in_company_id,
            in_branch_id     => in_branch_id
        );

    EXCEPTION
        WHEN OTHERS THEN
        out_error_code := SQLCODE;
        out_error_text := SQLERRM;
    END;
    
    /*
    -- During Invoice Matching (Expense Part)   --   AP
    */
    
    PROCEDURE ap_invoice_expense_transfer (
        inv_id           IN     NUMBER,
        user_id          IN     NUMBER,
        gl_v_id          IN     NUMBER,
        in_company_id    IN     NUMBER,
        in_branch_id     IN     VARCHAR2
    )
    IS
        company    NUMBER  :=  in_company_id;
        branch     VARCHAR2(20) := in_branch_id;
        v_id       NUMBER;
        v_no       NUMBER;
        chk        NUMBER;
        acc_date   DATE;
        remarks    VARCHAR2(300);
    BEGIN
        SELECT TRUNC(invoice_date), 
               i.invoice_amount
        INTO acc_date, 
             chk
        FROM ap_invoices i    
        WHERE invoice_id = inv_id;
       
        IF gl_v_id IS NULL THEN
            SELECT gl_voucher_id_s.NEXTVAL    
            INTO v_id      
            FROM dual;
            
            v_no := get_voucher_no(acc_date,'JVP',company,branch);
            
            INSERT INTO gl_vouchers (
                voucher_id, 
                voucher_type, 
                voucher_no, 
                voucher_date,
                description, 
                created_by, 
                creation_date,
                last_updated_by, 
                last_updated_date, 
                status,
                approved_by, 
                approval_date, 
                posted_by, 
                posting_date, 
                module,
                module_doc, 
                module_doc_id, 
                company_id, 
                branch_id
            )
            SELECT v_id, 
                   'JVP',
                   v_no,
                   acc_date, 
                   'Entry Aginst Invoice ID '|| si.invoice_id , 
                   si.created_by,
                   si.creation_date, 
                   si.last_updated_by, 
                   si.last_update_date,
                  'PREPARED',
                  NULL, 
                  NULL, 
                  NULL, 
                  NULL,
                  'AP', 
                  'INVOICE', 
                  si.invoice_id, 
                  company, 
                  branch
            FROM ap_invoices si, 
                 inv_vendors c
            WHERE si.vendor_id = c.vendor_id 
            AND si.invoice_id = inv_id;
        ELSE
            v_id:=gl_v_id;
        END IF;

        INSERT INTO gl_voucher_accounts (
            voucher_account_id, 
            voucher_id, 
            account_id, 
            debit, 
            credit,
            naration, 
            created_by, 
            creation_date, 
            last_updated_by,
            last_update_date, 
            reference_id
        )
        SELECT gl_voucher_account_id_s.NEXTVAL, 
               v_id, account_id, 
               dr,
               cr, 
               naration, 
               user_id, 
               SYSDATE, 
               user_id, 
               SYSDATE,
               invoice_id
        FROM ap_inv_expense_transfer_v
        WHERE invoice_id = inv_id;
        
        UPDATE ap_invoices
        SET gl_voucher_expense_id = v_id
        WHERE invoice_id = inv_id;
        
        COMMIT;
    END;
    
    /*
    -- Auto voucher generation during invoice Matching  --   AP
    */
    
    PROCEDURE ap_invoice_transfer (
        inv_id           IN     NUMBER,
        user_id          IN     NUMBER,
        gl_v_id          IN     NUMBER,
        in_company_id    IN     NUMBER,
        in_branch_id     IN     VARCHAR2,
        out_error_code   OUT    VARCHAR2,
        out_error_text   OUT    VARCHAR2
    )
    IS
        company    NUMBER  :=  in_company_id;
        branch     VARCHAR2(20) := in_branch_id;
        v_id       NUMBER;
        v_no       NUMBER;
        chk        NUMBER;
        acc_date   DATE;
        remarks    VARCHAR2(300);
    BEGIN
        SELECT TRUNC(accounting_date), 
               i.invoice_amount
        INTO acc_date, 
             chk
        FROM ap_invoices i    
        WHERE invoice_id = inv_id;
       
        IF gl_v_id IS NULL THEN
            SELECT gl_voucher_id_s.NEXTVAL    
            INTO v_id      
            FROM dual;
            
            v_no := get_voucher_no(acc_date,'JVP',company,branch);
            
            INSERT INTO gl_vouchers (
                voucher_id, 
                voucher_type, 
                voucher_no, 
                voucher_date,
                description, 
                created_by, 
                creation_date,
                last_updated_by, 
                last_updated_date, 
                status,
                approved_by, 
                approval_date, 
                posted_by, 
                posting_date, 
                module,
                module_doc, 
                module_doc_id, 
                company_id, 
                branch_id
            )
            SELECT v_id, 
                   'JVP',
                   v_no,
                   acc_date, 
                   'Entry Aginst Invoice ID '|| si.invoice_id, 
                   si.created_by,
                   si.creation_date, 
                   si.last_updated_by, 
                   si.last_update_date,
                  'PREPARED',
                  NULL, 
                  NULL, 
                  NULL, 
                  NULL,
                  'AP', 
                  'INVOICE', 
                  si.invoice_id, 
                  company, 
                  branch
            FROM ap_invoices si, 
                 inv_vendors c
            WHERE si.vendor_id = c.vendor_id 
            AND si.invoice_id = inv_id;
        ELSE
            v_id:=gl_v_id;
        END IF;

        IF chk > 0  THEN
            INSERT INTO gl_voucher_accounts (
                voucher_account_id, 
                voucher_id, 
                account_id, 
                debit, 
                credit,
                naration, 
                created_by, 
                creation_date, 
                last_updated_by,
                last_update_date, 
                reference_id
            )
            SELECT gl_voucher_account_id_s.NEXTVAL, 
                   v_id, 
                   account_id, 
                   debit,
                   credit, 
                   naration, 
                   user_id, 
                   SYSDATE, 
                   user_id, 
                   SYSDATE,
                   invoice_id
            FROM ap_invoice_transfer_v
            WHERE invoice_id = inv_id;
        ELSIF chk < 0 THEN
            INSERT INTO gl_voucher_accounts (
                voucher_account_id, 
                voucher_id, 
                account_id, 
                debit, 
                credit,
                naration, 
                created_by, 
                creation_date, 
                last_updated_by,
                last_update_date, 
                reference_id
            )
            SELECT gl_voucher_account_id_s.NEXTVAL, 
                   v_id, 
                   account_id, 
                   debit,
                   credit, 
                   naration, 
                   user_id, 
                   SYSDATE, 
                   user_id, 
                   SYSDATE,
                   invoice_id
            FROM ap_debit_transfer_v
            WHERE invoice_id = inv_id;
        END IF;
        
        UPDATE ap_invoices
        SET gl_voucher_id = v_id
        WHERE invoice_id = inv_id;
        
        COMMIT;
        
        
        --****************** For the expense part
        /*
        acc_supp.ap_invoice_expense_transfer (
            inv_id           => inv_id,
            user_id          => user_id,
            gl_v_id          => gl_v_id,
            in_company_id    => in_company_id,
            in_branch_id     => in_branch_id
        );
        
        COMMIT;
        */
    EXCEPTION
        WHEN OTHERS THEN
        out_error_code := SQLCODE;
        out_error_text := SQLERRM;
    END ;
    
    /*
    -- during Payment            AP
    */
    
    
    FUNCTION gl_add_voucher (
        x_voucher_type          VARCHAR2,
        x_voucher_date          DATE,
        x_description           VARCHAR2,
        x_created_by            NUMBER,
        x_creation_date         DATE,
        x_approved_by           NUMBER,
        x_status                VARCHAR2,
        x_company_id            NUMBER,
        x_branch_id             VARCHAR2,
        x_module                VARCHAR2,
        x_module_doc            VARCHAR2,
        x_module_doc_id         NUMBER,
        x_reference_no          VARCHAR2,
        x_reference_date        DATE,
        x_paid_amount           NUMBER
    ) RETURN NUMBER
    IS
        xx_voucher_id NUMBER;
        xx_voucher_no NUMBER;
    BEGIN
        SELECT gl_voucher_id_s.NEXTVAL
        INTO xx_voucher_id
        FROM dual;
        
        xx_voucher_no := get_voucher_no (x_voucher_date,x_voucher_type,x_company_id,x_branch_id) ;
        
        INSERT INTO gl_vouchers (
            voucher_id,
            voucher_no,
            voucher_type,
            voucher_date,
            description,
            created_by,
            creation_date,
            status,
            approved_by,
            approval_date,
            company_id,
            branch_id,
            module,
            module_doc,
            module_doc_id,
            reference_no,
            ref_date,
            paid_amount
        )
        VALUES (
            xx_voucher_id,
            xx_voucher_no,
            x_voucher_type,
            TRUNC(x_voucher_date),
            x_description,
            x_created_by,
            x_creation_date,
            x_status,
            x_approved_by,
            NULL,
            x_company_id,
            x_branch_id,
            x_module,
            x_module_doc,
            x_module_doc_id,
            x_reference_no,
            x_reference_date,
            x_paid_amount
        );
        RETURN xx_voucher_id;
    EXCEPTION
        WHEN OTHERS THEN
        RETURN NULL;
    END;
    
    /*
    -- Auto voucher generation during Payment              AP
    */
    
    PROCEDURE ap_payment_transfer (
        pay_id           IN     NUMBER,
        user_id          IN     NUMBER,
        gl_v_id          IN     NUMBER,
        in_company_id    IN     NUMBER,
        in_branch_id     IN     VARCHAR2,
        out_error_code   OUT    VARCHAR2,
        out_error_text   OUT    VARCHAR2
    )
    IS
        company       NUMBER := in_company_id;
        branch        VARCHAR2(20) := in_branch_id;
        v_id          NUMBER;
        v_no          NUMBER;
        acc_date      DATE;
        description   VARCHAR(250);
        pay_mode      VARCHAR(250);
        ref_no        VARCHAR(250);
        ref_date      DATE;
        pay_amount    NUMBER;
        created_by    NUMBER;
        creation_date DATE;
    BEGIN
        SELECT payment_date,
               paid_amount, 
               'Entry Aginst Payment ID '|| pay_id,
               DECODE (payment_mode, 'CASH', 'CPV', 'BPV'),
               doc_no,
               payment_date,
               created_by,
               TRUNC(creation_date),1
        INTO acc_date,
             pay_amount, 
             description,
             pay_mode,
             ref_no,
             ref_date,
             created_by,
             creation_date, 
             company
        FROM ap_payments
        WHERE payment_id = pay_id;

        IF gl_v_id IS NULL THEN
            v_id := acc_supp.gl_add_voucher(pay_mode,
                                            acc_date,
                                            DESCRIPTION,
                                            created_by,
                                            creation_date,
                                            NULL,
                                            'PREPARED',
                                            company,
                                            branch,
                                            'AP',
                                            'PAYMENT',
                                            pay_id,
                                            ref_no,
                                            ref_date,
                                            pay_amount);
        ELSE
            v_id:=gl_v_id;
        END IF;

        INSERT INTO gl_voucher_accounts (
            voucher_account_id, 
            voucher_id, 
            account_id, 
            debit, 
            credit,
            naration, 
            created_by, 
            creation_date, 
            last_updated_by,
            last_update_date, 
            reference_id
        )
        SELECT gl_voucher_account_id_s.NEXTVAL, 
               v_id, 
               account_id, 
               debit, 
               credit,
               naration, 
               user_id, 
               SYSDATE, 
               user_id, 
               SYSDATE, 
               payment_id
        FROM ap_payment_transfer_v
        WHERE payment_id = pay_id
        AND branch_id = in_branch_id;
        
        UPDATE ap_payments
        SET gl_voucher_id = v_id
        WHERE payment_id = pay_id;
        
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        out_error_code := SQLCODE;
        out_error_text := SQLERRM;
    END; 
    
    
    /*
    -- This Consumption voucher will be generated during Delivery Challan  AP
    */
    
    PROCEDURE ap_delivery_challan_transfer (
        in_dc_id         IN     NUMBER,
        in_user_id       IN     NUMBER,
        in_company_id    IN     NUMBER,
        in_branch_id     IN     VARCHAR2,
        out_error_code   OUT    VARCHAR2,
        out_error_text   OUT    VARCHAR2
    )
    IS
        company    NUMBER       := in_company_id;
        branch     VARCHAR2(20) := in_branch_id;
        batchid    NUMBER;
        v_id       NUMBER;
        v_no       NUMBER;
        acc_date   DATE;
    BEGIN
        SELECT gl_voucher_id_s.NEXTVAL
        INTO v_id
        FROM dual;

        SELECT TRUNC(challan_date) 
        INTO acc_date
        FROM inv_delivery_challans
        WHERE challan_id = in_dc_id;


        v_no:=get_voucher_no(acc_date,'JVP',company,branch);
            
        INSERT INTO gl_vouchers (
            voucher_id, 
            voucher_type, 
            voucher_no, 
            voucher_date,
            description, 
            created_by, 
            creation_date,
            last_updated_by, 
            last_updated_date, 
            status,
            approved_by, 
            approval_date, 
            posted_by, 
            posting_date, 
            module,
            module_doc, 
            module_doc_id, 
            company_id, 
            branch_id
        )
        SELECT v_id, 
               'JVP', 
               v_no,
               acc_date, 
               'Entry Against DC# '|| dc.challan_id , 
               dc.created_by,
               dc.creation_date, 
               dc.last_updated_by, 
               dc.last_update_date,
               'PREPARED', 
               NULL, 
               NULL, 
               NULL, 
               NULL,
               'AR', 
               'DELIVERY_CHALLAN', 
               dc.challan_id, 
               company, 
               branch
        FROM inv_delivery_challans dc
        WHERE dc.challan_id = in_dc_id;
        
        
        INSERT INTO gl_voucher_accounts (
            voucher_account_id, 
            voucher_id, 
            account_id, 
            debit, 
            credit,
            naration, 
            created_by, 
            creation_date, 
            last_updated_by,
            last_update_date, 
            reference_id
        )
        SELECT gl_voucher_account_id_s.NEXTVAL, 
               v_id, 
               account_id, 
               debit, 
               credit,
               narration, 
               in_user_id, 
               SYSDATE, 
               in_user_id, 
               SYSDATE, 
               challan_id
        FROM ap_delivery_challan_transfer
        WHERE challan_id = in_dc_id
        AND branch_id = in_branch_id;
        
        
        UPDATE inv_delivery_challans
        SET gl_voucher_id = v_id
        WHERE challan_id = in_dc_id;
        
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        out_error_code := SQLCODE;
        out_error_text := SQLERRM;
    END; 
    
    
    /*
     -- This voucher will be generated When sale invoice Save.  AR
    */
    
    -- voucher type --  JVR
    -- module -- AR
    -- receipt type -- 07
    -- receipt from -- 01
    -- receipt from id -- cust id
    
    PROCEDURE ar_invoice_transfer (
        in_inv_id        IN     NUMBER,
        in_user_id       IN     NUMBER,
        in_gl_v_id       IN     NUMBER,
        in_company_id    IN     NUMBER,
        in_branch_id     IN     VARCHAR2,
        out_error_code   OUT    VARCHAR2,
        out_error_text   OUT    VARCHAR2
    )
    IS
        company    NUMBER := in_company_id;
        branch     VARCHAR2(20) := in_branch_id;
        batchid    NUMBER;
        v_id       NUMBER;
        v_no       NUMBER;
        acc_date   DATE;
        l_cnt      NUMBER;
        l_out_error_code VARCHAR2(50);
        l_out_error_text VARCHAR2(200);
    BEGIN
        IF in_gl_v_id IS NULL THEN
            
            SELECT gl_voucher_id_s.NEXTVAL
            INTO v_id
            FROM dual;

            SELECT TRUNC(invoice_date) ,
                   1
            INTO acc_date,
                 company
            FROM inv_sales_invoices
            WHERE sales_invoice_id = in_inv_id;


            v_no:=get_voucher_no(acc_date,'JVR',company,branch);
            
            INSERT INTO gl_vouchers (
                voucher_id, 
                voucher_type, 
                voucher_no, 
                voucher_date,
                description, 
                created_by, 
                creation_date,
                last_updated_by, 
                last_updated_date, 
                status,
                approved_by, 
                approval_date, 
                posted_by, 
                posting_date, 
                module,
                module_doc, 
                module_doc_id, 
                company_id, 
                branch_id, 
                reference_no , 
                receive_type, 
                receive_from_id, 
                receive_from , 
                cheked_by, 
                checked_date 
            )
            SELECT v_id, 
                   'JVR',
                   v_no,
                   acc_date, 
                   'Entry Against Sale Invoice# '|| si.sales_invoice_id, 
                   si.created_by,
                   si.creation_date, 
                   si.last_updated_by, 
                   SYSDATE,
                   'APPROVED', 
                   234, 
                   SYSDATE, 
                   NULL, 
                   NULL,
                   'AR', 
                   'SALE_INVOICE', 
                   si.sales_invoice_id, 
                   company, 
                   branch, 
                   si.invoice_no, 
                   '07', 
                   si.customer_id , 
                   '01', 
                   234, 
                   si.invoice_date
            FROM inv_sales_invoices si, 
                 ar_customers c
            WHERE si.customer_id = c.customer_id 
            AND si.sales_invoice_id = in_inv_id;
        ELSE
            v_id:= in_gl_v_id;
        END IF;

        INSERT INTO gl_voucher_accounts (
            voucher_account_id, 
            voucher_id, 
            account_id, 
            debit, 
            credit,
            naration, 
            created_by, 
            creation_date, 
            last_updated_by,
            last_update_date, 
            reference_id
        )
        SELECT gl_voucher_account_id_s.NEXTVAL, 
               v_id, 
               receiveable_account_id, 
               debit, 
               credit,
               naration, 
               in_user_id, 
               SYSDATE, 
               in_user_id, 
               SYSDATE, 
               sales_invoice_id
        FROM ar_invoice_transfer_v
        WHERE sales_invoice_id = in_inv_id
        AND branch_id = branch;
       
     
        UPDATE inv_sales_invoices 
        SET gl_voucher_id = v_id 
        WHERE sales_invoice_id = in_inv_id;
        
        
        SELECT COUNT(*)
        INTO l_cnt
        FROM ar_invoice_security_trn_v
        WHERE sales_invoice_id = in_inv_id;
        
        IF l_cnt > 0 THEN
            acc_supp.ar_invoice_security_deposite (
                in_inv_id        => in_inv_id,
                in_user_id       => in_user_id,
                in_gl_v_id       => null,
                in_company_id    => in_company_id,
                in_branch_id     => in_branch_id,
                out_error_code   => l_out_error_code,
                out_error_text   => l_out_error_text
            );
        END IF;
        

        COMMIT;
    
    EXCEPTION
        WHEN OTHERS THEN
        out_error_code := SQLCODE;
        out_error_text := SQLERRM;
    END;
    
    /*
    --  voucher will be generated when invoice amount has a security deposite part
    */
    
    PROCEDURE ar_invoice_security_deposite (
        in_inv_id        IN     NUMBER,
        in_user_id       IN     NUMBER,
        in_gl_v_id       IN     NUMBER,
        in_company_id    IN     NUMBER,
        in_branch_id     IN     VARCHAR2,
        out_error_code   OUT    VARCHAR2,
        out_error_text   OUT    VARCHAR2
    ) IS
        company    NUMBER := in_company_id;
        branch     VARCHAR2(20) := in_branch_id;
        batchid    NUMBER;
        v_id       NUMBER;
        v_no       NUMBER;
        acc_date   DATE;
    BEGIN
        IF in_gl_v_id IS NULL THEN
            
            SELECT gl_voucher_id_s.NEXTVAL
            INTO v_id
            FROM dual;

            SELECT TRUNC(invoice_date) ,
                   1
            INTO acc_date,
                 company
            FROM inv_sales_invoices
            WHERE sales_invoice_id = in_inv_id;


            v_no:=get_voucher_no(acc_date,'JVR',company,branch);
            
            INSERT INTO gl_vouchers (
                voucher_id, 
                voucher_type, 
                voucher_no, 
                voucher_date,
                description, 
                created_by, 
                creation_date,
                last_updated_by, 
                last_updated_date, 
                status,
                approved_by, 
                approval_date, 
                posted_by, 
                posting_date, 
                module,
                module_doc, 
                module_doc_id, 
                company_id, 
                branch_id, 
                reference_no , 
                receive_type, 
                receive_from_id, 
                receive_from , 
                cheked_by, 
                checked_date
            )
            SELECT v_id, 
                   'JVR',
                   v_no,
                   acc_date, 
                   'Entry Against Sale Invoice# '|| si.sales_invoice_id, 
                   si.created_by,
                   si.creation_date, 
                   si.last_updated_by, 
                   SYSDATE,
                   'APPROVED', 
                   NULL, 
                   NULL, 
                   NULL, 
                   NULL,
                   'AR', 
                   'SECURITY_DEPOSITE', 
                   si.sales_invoice_id, 
                   company, 
                   branch , 
                   si.invoice_no, 
                   '07', 
                   si.customer_id , 
                   '01', 
                   234, 
                   si.invoice_date
            FROM inv_sales_invoices si, 
                 ar_customers c
            WHERE si.customer_id = c.customer_id 
            AND si.sales_invoice_id = in_inv_id;
        ELSE
            v_id:= in_gl_v_id;
        END IF;

        INSERT INTO gl_voucher_accounts (
            voucher_account_id, 
            voucher_id, 
            account_id, 
            debit, 
            credit,
            naration, 
            created_by, 
            creation_date, 
            last_updated_by,
            last_update_date, 
            reference_id
        )
        SELECT gl_voucher_account_id_s.NEXTVAL, 
               v_id, 
               receiveable_account_id, 
               debit, 
               credit,
               narration, 
               in_user_id, 
               SYSDATE, 
               in_user_id, 
               SYSDATE, 
               sales_invoice_id
        FROM ar_invoice_security_trn_v
        WHERE sales_invoice_id = in_inv_id
        AND branch_id = branch;
        
        UPDATE inv_sales_invoices 
        SET gl_security_voucher_id = v_id 
        WHERE sales_invoice_id = in_inv_id;

        COMMIT;
    
    EXCEPTION
        WHEN OTHERS THEN
        out_error_code := SQLCODE;
        out_error_text := SQLERRM;
    END;
    
    
    /*
    -- Auto voucher generation during AR Receipt           AR
    */
    
    
    PROCEDURE ar_cheque_transfer (
        rec_id           IN     NUMBER,
        user_id          IN     NUMBER,
        gl_v_id          IN     NUMBER,
        in_company_id    IN     NUMBER,
        in_branch_id     IN     VARCHAR2,
        out_error_code   OUT    VARCHAR2,
        out_error_text   OUT    VARCHAR2
    )
    IS
        company    NUMBER := in_company_id;
        branch     VARCHAR(20) := in_branch_id;
        batchid    NUMBER;
        v_id       NUMBER;
        v_no       NUMBER;
        acc_date   DATE;
        v_type     VARCHAR2(10);
        i          NUMBER;
    BEGIN
        --i := 1/0;
      
        IF gl_v_id IS NULL THEN
            SELECT gl_voucher_id_s.NEXTVAL 
            INTO v_id 
            FROM DUAL;

            SELECT DECODE (accounted_date, null, receipt_date, accounted_date),
                   in_company_id, 
                   DECODE (payment_mode, 'CASH', 'CRV', 'BRV')
            INTO acc_date,
                 company, 
                 v_type
            FROM ar_receipts
            WHERE receipt_id = rec_id;

            v_no:=get_voucher_no (acc_date,v_type,company,branch) ;
        ELSE
            v_id:=gl_v_id;
        END IF;

        IF gl_v_id IS NULL THEN
            INSERT INTO gl_vouchers (
                voucher_id, 
                voucher_type, 
                voucher_no, 
                voucher_date,
                description, 
                batch_id, 
                created_by, 
                creation_date,
                last_updated_by, 
                last_updated_date, 
                status,
                approved_by, 
                approval_date,
                module, 
                module_doc, 
                module_doc_id, 
                company_id, 
                branch_id,
                reference_no
            )
            SELECT v_id, 
                   DECODE (r.payment_mode, 'CASH', 'CRV', 'BRV'), v_no,
                   TRUNC(acc_date) , 
                   r.remarks, 
                   batchid, 
                   r.created_by, 
                   r.creation_date,
                   r.last_updated_by, 
                   r.last_update_date, 
                   'PREPARED',
                   NULL, 
                   NULL,
                   'AR',
                   'RECEIPT', 
                   r.receipt_id, 
                   company, 
                   branch, 
                   r.doc_no
            FROM ar_receipts r    
            WHERE r.receipt_id = rec_id;
        END IF;
        INSERT INTO gl_voucher_accounts (
            voucher_account_id, 
            voucher_id, 
            account_id, 
            debit, 
            credit,
            naration, 
            created_by, 
            creation_date, 
            last_updated_by,
            last_update_date, 
            reference_id
        )
        SELECT gl_voucher_account_id_s.NEXTVAL, 
               v_id, 
               account_id, 
               debit,
               credit, 
               naration, 
               user_id, 
               SYSDATE, 
               user_id, 
               SYSDATE, 
               receipt_id
        FROM ar_cheque_transfer_v
        WHERE receipt_id = rec_id
        AND branch_id = in_branch_id;

        UPDATE ar_receipts
        SET    gl_voucher_id=v_id
        WHERE  receipt_id = rec_id;
        
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        out_error_code := SQLCODE;
        out_error_text := SQLERRM;
    END;
    
    
    /*
    -- During DO Approval Advance Payment Voucher will be generated
    */
   
    -- voucher type --  BRV
    -- module -- AR
    -- receipt type -- 06
    -- receipt from -- 01
    -- receipt from id -- cust id
    
    PROCEDURE ar_do_transfer (
        do_id            IN     NUMBER,
        user_id          IN     NUMBER,
        gl_v_id          IN     NUMBER,
        in_company_id    IN     NUMBER,
        in_branch_id     IN     VARCHAR2,
        out_error_code   OUT    VARCHAR2,
        out_error_text   OUT    VARCHAR2
    )
    IS
        company    NUMBER := in_company_id;
        branch     VARCHAR(20) := in_branch_id;
        batchid    NUMBER;
        v_id       NUMBER;
        v_no       NUMBER;
        acc_date   DATE;
        v_type     VARCHAR2(10);
        i          NUMBER;
        l_amount   NUMBER;
        l_receivable_account_id NUMBER;
        l_cust_id  NUMBER;
        l_code VARCHAR2(50);
        l_text VARCHAR2(500);
        l_cnt NUMBER;
    BEGIN
        IF gl_v_id IS NULL THEN
            SELECT gl_voucher_id_s.NEXTVAL 
            INTO v_id 
            FROM DUAL;

            SELECT approved_date,
                   in_company_id, 
                   'BRV'
            INTO acc_date,
                 company, 
                 v_type
            FROM inv_sales_orders
            WHERE sales_order_id = do_id;

            v_no:=get_voucher_no (acc_date,v_type,company,branch) ;
        ELSE
            v_id:=gl_v_id;
        END IF;

        IF gl_v_id IS NULL THEN
            INSERT INTO gl_vouchers (
                voucher_id, 
                voucher_type, 
                voucher_no, 
                voucher_date,
                description, 
                batch_id, 
                created_by, 
                creation_date,
                last_updated_by, 
                last_updated_date, 
                status,
                approved_by, 
                approval_date,
                module, 
                module_doc, 
                module_doc_id, 
                company_id, 
                branch_id,
                reference_no , 
                receive_type, 
                receive_from_id, 
                receive_from , 
                cheked_by, 
                checked_date 
            )
            SELECT v_id, 
                   'BRV', 
                   v_no, 
                   SYSDATE, 
                   'Entry Against DO# '|| r.po_no, 
                   batchid, 
                   user_id, 
                   SYSDATE,
                   NULL, 
                   NULL, 
                   'APPROVED',
                   user_id, 
                   SYSDATE,
                   'AR',
                   'DO APPROVE', 
                   r.sales_order_id, 
                   company, 
                   branch, 
                   r.po_no , 
                   '06' , 
                   r.customer_id , 
                   '01' , 
                   user_id , 
                   SYSDATE
            FROM inv_sales_orders r    
            WHERE r.sales_order_id = do_id;
        END IF;
        
        INSERT INTO gl_voucher_accounts (
            voucher_account_id, 
            voucher_id, 
            account_id, 
            debit, 
            credit,
            naration, 
            created_by, 
            creation_date, 
            last_updated_by,
            last_update_date, 
            reference_id
        )
        SELECT gl_voucher_account_id_s.NEXTVAL, 
               v_id, 
               receiveable_account_id, 
               debit,
               credit, 
               naration, 
               user_id, 
               SYSDATE, 
               NULL, 
               NULL, 
               sales_order_id
        FROM ar_do_transfer_v
        WHERE sales_order_id = do_id
        AND branch_id = in_branch_id;

        UPDATE inv_sales_orders
        SET    gl_voucher_id = v_id
        WHERE  sales_order_id = do_id;
        
        SELECT SUM(credit) , MAX(receiveable_account_id)
        INTO l_amount , l_receivable_account_id
        FROM ar_do_transfer_v
        WHERE sales_order_id = do_id
        AND debit = 0
        AND branch_id = in_branch_id;
        
        SELECT customer_id
        INTO l_cust_id
        FROM inv_sales_orders
        WHERE sales_order_id = do_id;
        
        UPDATE ar_customers_detail
        SET opening_balance = nvl(opening_balance,0) + NVL(l_amount,0)
        WHERE customer_id  = l_cust_id
        AND branch_id = in_branch_id;
        
        gbl_supp.send_sms_during_do (
            in_do_id   => do_id
        );
        
        COMMIT;
       
        SELECT NVL(COUNT(1),0)
        INTO l_cnt
        FROM ar_do_bank_charge
        WHERE sales_order_id = do_id;
        
        IF l_cnt > 0 THEN
        
            acc_supp.ar_do_bank_charge_trn (
                do_id            => do_id,
                user_id          => user_id,
                gl_v_id          => gl_v_id,
                in_company_id    => in_company_id,
                in_branch_id     => in_branch_id,
                out_error_code   => l_code,
                out_error_text   => l_text
            );
            
        END IF;
        
    EXCEPTION
        WHEN OTHERS THEN
        out_error_code := SQLCODE;
        out_error_text := SQLERRM;
    END;
    
    
    PROCEDURE ar_do_bank_charge_trn (
        do_id            IN     NUMBER,
        user_id          IN     NUMBER,
        gl_v_id          IN     NUMBER,
        in_company_id    IN     NUMBER,
        in_branch_id     IN     VARCHAR2,
        out_error_code   OUT    VARCHAR2,
        out_error_text   OUT    VARCHAR2
    )
    IS
        company    NUMBER := in_company_id;
        branch     VARCHAR(20) := in_branch_id;
        batchid    NUMBER;
        v_id       NUMBER;
        v_no       NUMBER;
        acc_date   DATE;
        v_type     VARCHAR2(10);
        i          NUMBER;
        l_amount   NUMBER;
        l_receivable_account_id NUMBER;
        l_cust_id  NUMBER;
    BEGIN
        IF gl_v_id IS NULL THEN
            SELECT gl_voucher_id_s.NEXTVAL 
            INTO v_id 
            FROM DUAL;

            SELECT approved_date,
                   in_company_id, 
                   'BPV'
            INTO acc_date,
                 company, 
                 v_type
            FROM inv_sales_orders
            WHERE sales_order_id = do_id;

            v_no:=get_voucher_no (acc_date,v_type,company,branch) ;
        ELSE
            v_id:=gl_v_id;
        END IF;

        IF gl_v_id IS NULL THEN
            INSERT INTO gl_vouchers (
                voucher_id, 
                voucher_type, 
                voucher_no, 
                voucher_date,
                description, 
                batch_id, 
                created_by, 
                creation_date,
                last_updated_by, 
                last_updated_date, 
                status,
                approved_by, 
                approval_date,
                module, 
                module_doc, 
                module_doc_id, 
                company_id, 
                branch_id,
                reference_no , 
                receive_type, 
                receive_from_id, 
                receive_from , 
                cheked_by, 
                checked_date 
            )
            SELECT v_id, 
                   'BPV', 
                   v_no, 
                   SYSDATE, 
                   'Entry Against DO for Bank Charge# '|| r.po_no, 
                   batchid, 
                   user_id, 
                   SYSDATE,
                   NULL, 
                   NULL, 
                   'APPROVED',
                   user_id, 
                   SYSDATE,
                   'AR',
                   'DO APPROVE', 
                   r.sales_order_id, 
                   company, 
                   branch, 
                   r.po_no , 
                   '06' , 
                   r.customer_id , 
                   '01' , 
                   user_id , 
                   SYSDATE
            FROM inv_sales_orders r    
            WHERE r.sales_order_id = do_id;
        END IF;
        
        INSERT INTO gl_voucher_accounts (
            voucher_account_id, 
            voucher_id, 
            account_id, 
            debit, 
            credit,
            naration, 
            created_by, 
            creation_date, 
            last_updated_by,
            last_update_date, 
            reference_id
        )
        SELECT gl_voucher_account_id_s.NEXTVAL, 
               v_id, 
               receiveable_account_id, 
               debit,
               credit, 
               naration, 
               user_id, 
               SYSDATE, 
               NULL, 
               NULL, 
               sales_order_id
        FROM ar_do_bank_charge
        WHERE sales_order_id = do_id
        AND branch_id = in_branch_id;
        
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        out_error_code := SQLCODE;
        out_error_text := SQLERRM;
    END;
  
    
    FUNCTION get_costing_exchange_rate (
        in_po_id         IN     NUMBER
    ) RETURN NUMBER
    IS
        CURSOR c1
        IS
        SELECT exch_rate
        FROM imp_ccns
        WHERE po_id = in_po_id;
        l_exchange_rate NUMBER;
    BEGIN
        OPEN c1;
            FETCH c1 INTO l_exchange_rate;
        CLOSE c1;
        RETURN l_exchange_rate;
    EXCEPTION
        WHEN OTHERS THEN
        RETURN NULL;
    END;
    
    FUNCTION get_po_exchange_rate (
        in_po_id         IN     NUMBER
    ) RETURN NUMBER
    IS
        CURSOR c1
        IS
        SELECT exch_rate
        FROM performa_inv_master
        WHERE po_no = in_po_id;
        l_exch_rate NUMBER;
    BEGIN
        OPEN c1;
            FETCH c1 INTO l_exch_rate;
        CLOSE c1;
        RETURN l_exch_rate;
    EXCEPTION
        WHEN OTHERS THEN
        RETURN NULL;
    END;
    
    
    FUNCTION po_exch_rate_from_inv (
        in_invoice_id       IN     NUMBER
    ) RETURN NUMBER
    IS
        CURSOR c1
        IS
        SELECT po_exch_rate
        FROM (
            SELECT po_exch_rate
            FROM ap_invoice_lines
            WHERE invoice_id = in_invoice_id
        )
        WHERE ROWNUM < 2 ;
        l_po_exch_rate NUMBER;
    BEGIN
        OPEN c1;
            FETCH c1 INTO l_po_exch_rate;
        CLOSE c1;
        RETURN l_po_exch_rate;
    EXCEPTION
        WHEN OTHERS THEN
        RETURN NULL;
    END;
    
    /*
    -- This function is for voucher creating 
    */
    
    FUNCTION get_voucher_no (
        v_date           IN     DATE, 
        v_type           IN     VARCHAR2, 
        p_company               NUMBER, 
        p_branch                VARCHAR2
    ) RETURN NUMBER
    IS
        v_no   NUMBER;
    BEGIN
        SELECT NVL (MAX (gv.voucher_no), 0) + 1
        INTO v_no
        FROM gl_vouchers gv
        WHERE gv.voucher_date BETWEEN TRUNC (v_date, 'Month') AND LAST_DAY (v_date)
        AND gv.voucher_type = v_type
        AND gv.COMPANY_ID = p_company
        AND gv.BRANCH_ID = p_branch;

        RETURN v_no;
    END;
    
    /*
    -- This function is for checking delivery challan export or local type.
      Y = Export 
      N = Local
    */
    
    FUNCTION check_export_in_dc (
        in_dc_id         IN     NUMBER
    ) RETURN VARCHAR2
    IS
        CURSOR c1
        IS
        SELECT chk_export
        FROM inv_delivery_challans
        WHERE challan_id = in_dc_id;
        l_chk_export VARCHAR2(20);
    BEGIN
        OPEN c1;
            FETCH c1 INTO l_chk_export;
        CLOSE c1;
        
        RETURN l_chk_export;
        
    EXCEPTION
        WHEN OTHERS THEN
        RETURN NULL;
    END;
    
    /*
     -- This function is for local or foreign gl account id of item
    */
    
    FUNCTION get_invoice_account_id (
        in_dc_id         IN     NUMBER,
        in_item_id       IN     NUMBER
    ) RETURN NUMBER
    IS
        CURSOR c1
        IS
        SELECT CASE 
                   WHEN check_export_in_dc (
                            in_dc_id         =>       in_dc_id
                        ) = 'N' THEN gl_loc_sal_acc_id
                   ELSE gl_for_sal_acc_id
                END account_id
        FROM inv_items         
        WHERE item_id = in_item_id;
        
        l_account_id NUMBER;
    BEGIN
        OPEN c1;
            FETCH c1 INTO l_account_id;
        CLOSE c1;
        
        RETURN l_account_id;
    EXCEPTION
        WHEN OTHERS THEN
        RETURN NULL;
    END;
    
    
    FUNCTION get_trial_balance (
        in_pnl_mst_id    IN     NUMBER,
        in_month_year    IN     VARCHAR2,
        in_record_level  IN     NUMBER,
        in_company_id    IN     NUMBER,
        in_branch_id     IN     VARCHAR2  
    ) RETURN NUMBER
    IS
        CURSOR trial_balance
        IS
        SELECT SUM(NVL(balance,0))
        FROM gl_trial_v
        WHERE record_level = in_record_level
        AND acc_id IN ( 
                        SELECT coa_level5_id
                        FROM gl_profit_loss_dtl 
                        WHERE pnl_mst_id = in_pnl_mst_id
                      )
        AND company_id = NVL(in_company_id, company_id)
        AND branch_id = NVL(in_branch_id, branch_id)
        AND TO_CHAR(voucher_date, 'MON-RRRR') = in_month_year
        AND status = 'APPROVED';
        
        l_balance NUMBER;
    BEGIN
        OPEN trial_balance;
            FETCH trial_balance INTO l_balance;
        CLOSE trial_balance;
        
        RETURN l_balance;
        
    EXCEPTION
        WHEN OTHERS THEN
        RETURN 0;
    END;
    
    FUNCTION get_fiscal_year_start_date (
        in_to_date       IN     DATE
    ) RETURN DATE
    IS
        CURSOR c1
        IS
        SELECT start_date
        FROM gl_fiscal_year
        WHERE in_to_date BETWEEN start_date AND end_date;
        
        l_fiscal_year_end_date DATE;
    BEGIN
        OPEN c1;
            FETCH c1 INTO l_fiscal_year_end_date;
        CLOSE c1;
        
        IF in_to_date >= '30-JUN-2024' THEN
            RETURN l_fiscal_year_end_date;
        ELSE
            RETURN NULL;
        END IF;
        
    EXCEPTION
        WHEN OTHERS THEN
        RETURN NULL;
    END;
        
    FUNCTION get_yearly_trial_balance (
        in_pnl_mst_id    IN     NUMBER,
        in_end_date      IN     DATE,
        in_record_level  IN     NUMBER,
        in_company_id    IN     NUMBER,
        in_branch_id     IN     VARCHAR2  
    ) RETURN NUMBER
    IS
        CURSOR fiscal_year
        IS
        SELECT start_date
        FROM gl_fiscal_year
        WHERE end_date = in_end_date;
        
        l_balance NUMBER;
        l_start_date DATE;
    BEGIN
    
        OPEN fiscal_year;
            FETCH fiscal_year INTO l_start_date; 
        CLOSE fiscal_year;
    
        SELECT SUM(NVL(balance,0)) 
        INTO l_balance
        FROM gl_trial_v
        WHERE record_level = in_record_level
        AND acc_id IN ( 
                        SELECT coa_level5_id
                        FROM gl_profit_loss_dtl 
                        WHERE pnl_mst_id = in_pnl_mst_id
                      )
        AND company_id = NVL(in_company_id, company_id)
        AND branch_id = NVL(in_branch_id, branch_id)
        AND voucher_date BETWEEN l_start_date AND TRUNC(SYSDATE,'MM')-1
        AND status = 'APPROVED';
        
        IF in_end_date < '30-JUN-2024' THEN
            RETURN 0;
        ELSE
            RETURN l_balance;
        END IF;
        
    EXCEPTION
        WHEN OTHERS THEN
        RETURN 0;
    END;
    
    PROCEDURE ins_gl_profit_loss_data (
        in_start_date    IN     DATE,
        in_end_date      IN     DATE,
        in_company_id    IN     NUMBER,
        in_branch_id     IN     VARCHAR2
    )
    IS
        CURSOR profit_loss_qty
        IS
        SELECT lev1.name lev1,
               lev3.name lev3,
               lev3.id lev3_id,
               TO_CHAR(d.fiscal_year) fiscal_year,
               d.qty,
               m.pnl_mst_id,
               d.fiscal_year year_n,
               0 month_n,
               lev1.serial level1_serial,
               lev2.serial level2_serial,
               0 cfy_qty
        FROM gl_profit_loss_mst m,
             gl_profit_loss_setup lev1,
             gl_profit_loss_setup lev2,
             gl_profit_loss_setup lev3,
             (
             SELECT pnl_mst_id,
                    fiscal_year,
                    from_date,
                    to_date,
                    amount,
                    qty
             FROM gl_profit_loss_prev_amt
             WHERE from_date >= in_start_date
             AND to_date <= in_end_date
             ) d
        WHERE m.pnl_mst_id = d.pnl_mst_id
        AND m.level1_setup_id = lev1.id
        AND m.level2_setup_id = lev2.id
        AND m.level3_setup_id = lev3.id
        AND m.company_id = NVL(in_company_id,m.company_id)
        AND m.branch_id = NVL(in_branch_id,m.branch_id)
        AND level2_setup_id IN (101,102) 
        UNION ALL
        SELECT lev1.name lev1,
               lev3.name lev3,
               lev3.id lev3_id,
               month||' - '||year,
               CASE 
                   WHEN level2_setup_id = 101 THEN sales_supp.get_bulk_sales_qty(this_year.month||'-'||this_year.year,NVL(in_company_id, m.company_id), NVL(in_branch_id, m.branch_id)) 
                   WHEN level2_setup_id = 102 THEN sales_supp.get_cylinder_sales_qty(this_year.month||'-'||this_year.year,NVL(in_company_id, m.company_id), NVL(in_branch_id, m.branch_id))
               END qty,
               m.pnl_mst_id,
               year year_n,
               month_n,
               lev1.serial level1_serial,
               lev2.serial level2_serial,
               CASE
                   WHEN lev3.id = 1001 then sales_supp.get_bulk_sales_cfy (
                                                in_to_date     => in_end_date,
                                                in_company_id  => in_company_id,
                                                in_branch_id   => in_branch_id
                                            )
                   WHEN lev3.id = 1002 then sales_supp.get_cylinder_sales_cfy (
                                                in_to_date     => in_end_date,
                                                in_company_id  => in_company_id,
                                                in_branch_id   => in_branch_id
                                            )
               END cfy_qty
        FROM(
            SELECT EXTRACT(MONTH FROM d) AS MONTH_N,
                   TO_CHAR(D,'MON') AS MONTH,
                   EXTRACT(YEAR FROM d) AS YEAR
            FROM (
                SELECT ADD_MONTHS(TO_DATE(acc_supp.get_fiscal_year_start_date(in_end_date)), LEVEL - 1) d
                FROM DUAL
                CONNECT BY
                ADD_MONTHS(TO_DATE(acc_supp.get_fiscal_year_start_date(in_end_date)), LEVEL - 1) <= TO_DATE(CASE WHEN TO_DATE(in_end_date) > SYSDATE THEN TRUNC(SYSDATE,'MM')-1 ELSE TO_DATE(in_end_date) END )
            )
            ) this_year,
            gl_profit_loss_mst m,
            gl_profit_loss_setup lev1,
            gl_profit_loss_setup lev2,
            gl_profit_loss_setup lev3
        WHERE m.level1_setup_id = lev1.id
        AND m.level2_setup_id = lev2.id
        AND m.level3_setup_id = lev3.id     
        AND m.company_id = NVL(in_company_id, m.company_id)
        AND m.branch_id = NVL(in_branch_id, m.branch_id)
        AND in_end_date >= '30-JUN-2024'
        AND level2_setup_id IN (101,102)
        ORDER BY year_n, month_n;
        
        CURSOR profit_loss_amt
        IS
        SELECT lev1.name lev1,
               lev3.name lev3,
               TO_CHAR(d.fiscal_year) fiscal_year,
               CASE 
                   WHEN NVL(m.signed_operator,'##') = '-' THEN -1 * d.amount 
                   ELSE d.amount 
               END amount,
               0 cfy_amt,
               m.pnl_mst_id,
               d.fiscal_year year_n,
               0 month_n,
               lev1.serial level1_serial,
               lev2.serial level2_serial,
               m.signed_operator,
               m.level3_setup_id
        FROM gl_profit_loss_mst m,
             gl_profit_loss_setup lev1,
             gl_profit_loss_setup lev2,
             gl_profit_loss_setup lev3,
             (
             SELECT pnl_mst_id,
                    fiscal_year,
                    from_date,
                    to_date,
                    amount,
                    qty
             FROM gl_profit_loss_prev_amt
             WHERE from_date >= in_start_date
             AND to_date <= in_end_date
             ) d
        WHERE m.pnl_mst_id = d.pnl_mst_id
        AND m.level1_setup_id = lev1.id
        AND m.level2_setup_id = lev2.id
        AND m.level3_setup_id = lev3.id
        AND m.company_id = NVL(in_company_id,m.company_id)
        AND m.branch_id = NVL(in_branch_id,m.branch_id)
        UNION ALL
        SELECT lev1.name lev1,
               lev3.name lev3,
               month||' - '||year,
               CASE 
                   WHEN NVL(m.signed_operator,'##') = '-' THEN -1 * acc_supp.get_trial_balance (m.pnl_mst_id, this_year.month||'-'||this_year.year , 5, NVL(in_company_id, m.company_id), NVL(in_branch_id, m.branch_id))
                   ELSE acc_supp.get_trial_balance (m.pnl_mst_id, this_year.month||'-'||this_year.year , 5, NVL(in_company_id, m.company_id), NVL(in_branch_id, m.branch_id)) 
               END amount,
               --acc_supp.get_trial_balance (m.pnl_mst_id, this_year.month||'-'||this_year.year , 5, NVL(in_company_id, m.company_id), NVL(in_branch_id, m.branch_id)) amount ,
               CASE 
                   WHEN NVL(m.signed_operator,'##') = '-' THEN -1 * acc_supp.get_yearly_trial_balance ( m.pnl_mst_id,in_end_date, 5, in_company_id, in_branch_id)
                   ELSE acc_supp.get_yearly_trial_balance ( m.pnl_mst_id,in_end_date, 5, in_company_id, in_branch_id)
               END cfy_amt,
               --acc_supp.get_yearly_trial_balance ( m.pnl_mst_id,in_end_date, 5, in_company_id, in_branch_id) cfy_amt,
               m.pnl_mst_id,
               TO_NUMBER(TO_CHAR(in_end_date, 'RRRR')) year_n,
               month_n,
               lev1.serial level1_serial,
               lev2.serial level2_serial,
               m.signed_operator,
               m.level3_setup_id
        FROM(
            SELECT EXTRACT(MONTH FROM d) AS MONTH_N,
                   TO_CHAR(D,'MON') AS MONTH,
                   EXTRACT(YEAR FROM d) AS YEAR
            FROM (
                SELECT ADD_MONTHS(TO_DATE(acc_supp.get_fiscal_year_start_date(in_end_date)), LEVEL - 1) d
                FROM DUAL
                CONNECT BY
                ADD_MONTHS(TO_DATE(acc_supp.get_fiscal_year_start_date(in_end_date)), LEVEL - 1) <= TO_DATE(CASE WHEN TO_DATE(in_end_date) > SYSDATE THEN TRUNC(SYSDATE,'MM')-1 ELSE TO_DATE(in_end_date) END )
            )
            ) this_year,
            gl_profit_loss_mst m,
            gl_profit_loss_setup lev1,
            gl_profit_loss_setup lev2,
            gl_profit_loss_setup lev3
        WHERE m.level1_setup_id = lev1.id
        AND m.level2_setup_id = lev2.id
        AND m.level3_setup_id = lev3.id     
        AND m.company_id = NVL(in_company_id, m.company_id)
        AND m.branch_id = NVL(in_branch_id, m.branch_id)
        AND in_end_date >= '30-JUN-2024'
        ORDER BY year_n, month_n;
        
        CURSOR profit_loss_amt_sum
        IS
        SELECT total_fiscal_year,
               year_n total_year_n,
               month_n total_month_n,
               SUM(amount) total_amount
        FROM (
            SELECT lev1.name lev1,
                   lev3.name lev3,
                   TO_CHAR(d.fiscal_year) total_fiscal_year,
                   CASE 
                       WHEN NVL(m.signed_operator,'##') = '-' THEN -1 * d.amount 
                       ELSE d.amount 
                   END amount,
                   d.fiscal_year year_n,
                   0 month_n
            FROM gl_profit_loss_mst m,
                 gl_profit_loss_setup lev1,
                 gl_profit_loss_setup lev2,
                 gl_profit_loss_setup lev3,
                 (
                 SELECT pnl_mst_id,
                        fiscal_year,
                        from_date,
                        to_date,
                        amount,
                        qty
                 FROM gl_profit_loss_prev_amt
                 WHERE from_date >= in_start_date
                 AND to_date <= in_end_date
                 ) d
            WHERE m.pnl_mst_id = d.pnl_mst_id
            AND m.level1_setup_id = lev1.id
            AND m.level2_setup_id = lev2.id
            AND m.level3_setup_id = lev3.id
            AND m.company_id = NVL(in_company_id,m.company_id)
            AND m.branch_id = NVL(in_branch_id,m.branch_id)
            UNION ALL
            SELECT lev1.name lev1,
                   lev3.name lev3,
                   month||' - '||year fiscal_year,
                   CASE 
                       WHEN NVL(m.signed_operator,'##') = '-' THEN -1 * acc_supp.get_trial_balance (m.pnl_mst_id, this_year.month||'-'||this_year.year , 5, NVL(in_company_id, m.company_id), NVL(in_branch_id, m.branch_id))
                       ELSE acc_supp.get_trial_balance (m.pnl_mst_id, this_year.month||'-'||this_year.year , 5, NVL(in_company_id, m.company_id), NVL(in_branch_id, m.branch_id))
                   END amount,
                   --acc_supp.get_trial_balance (m.pnl_mst_id, this_year.month||'-'||this_year.year , 5, NVL(in_company_id, m.company_id), NVL(in_branch_id, m.branch_id)) amount,
                   TO_NUMBER(TO_CHAR(in_end_date, 'RRRR')) year_n,
                   month_n
            FROM(
                SELECT EXTRACT(MONTH FROM d) AS MONTH_N,
                       TO_CHAR(D,'MON') AS MONTH,
                       EXTRACT(YEAR FROM d) AS YEAR
                FROM (
                    SELECT ADD_MONTHS(TO_DATE(acc_supp.get_fiscal_year_start_date(in_end_date)), LEVEL - 1) d
                    FROM DUAL
                    CONNECT BY
                    ADD_MONTHS(TO_DATE(acc_supp.get_fiscal_year_start_date(in_end_date)), LEVEL - 1) <= TO_DATE(CASE WHEN TO_DATE(in_end_date) > SYSDATE THEN TRUNC(SYSDATE,'MM')-1 ELSE TO_DATE(in_end_date) END )
                )
                ) this_year,
                gl_profit_loss_mst m,
                gl_profit_loss_setup lev1,
                gl_profit_loss_setup lev2,
                gl_profit_loss_setup lev3
            WHERE m.level1_setup_id = lev1.id
            AND m.level2_setup_id = lev2.id
            AND m.level3_setup_id = lev3.id     
            AND m.company_id = NVL(in_company_id, m.company_id)
            AND m.branch_id = NVL(in_branch_id, m.branch_id)
            AND in_end_date >= '30-JUN-2024'
        )
        GROUP BY total_fiscal_year,
                 year_n,
                 month_n
        ORDER BY 2,3;
        
        CURSOR gross_profit
        IS
        SELECT total_fiscal_year,
               year_n total_year_n,
               month_n total_month_n,
               SUM(amount) total_amount
        FROM (
            SELECT lev1.name lev1,
                   lev3.name lev3,
                   TO_CHAR(d.fiscal_year) total_fiscal_year,
                   CASE 
                       WHEN NVL(m.signed_operator,'##') = '-' THEN -1 * d.amount 
                       ELSE d.amount 
                   END amount,
                   d.fiscal_year year_n,
                   0 month_n
            FROM gl_profit_loss_mst m,
                 gl_profit_loss_setup lev1,
                 gl_profit_loss_setup lev2,
                 gl_profit_loss_setup lev3,
                 (
                 SELECT pnl_mst_id,
                        fiscal_year,
                        from_date,
                        to_date,
                        amount,
                        qty
                 FROM gl_profit_loss_prev_amt
                 WHERE from_date >= in_start_date
                 AND to_date <= in_end_date
                 ) d
            WHERE m.pnl_mst_id = d.pnl_mst_id
            AND m.level1_setup_id = lev1.id
            AND m.level2_setup_id = lev2.id
            AND m.level3_setup_id = lev3.id
            AND m.company_id = NVL(in_company_id,m.company_id)
            AND m.branch_id = NVL(in_branch_id,m.branch_id)
            AND m.level2_setup_id >= 101 AND m.level2_setup_id <= 215 
            UNION ALL
            SELECT lev1.name lev1,
                   lev3.name lev3,
                   month||' - '||year fiscal_year,
                   CASE 
                       WHEN NVL(m.signed_operator,'##') = '-' THEN -1 * acc_supp.get_trial_balance (m.pnl_mst_id, this_year.month||'-'||this_year.year , 5, NVL(in_company_id, m.company_id), NVL(in_branch_id, m.branch_id))
                       ELSE acc_supp.get_trial_balance (m.pnl_mst_id, this_year.month||'-'||this_year.year , 5, NVL(in_company_id, m.company_id), NVL(in_branch_id, m.branch_id))
                   END amount,
                   --acc_supp.get_trial_balance (m.pnl_mst_id, this_year.month||'-'||this_year.year , 5, NVL(in_company_id, m.company_id), NVL(in_branch_id, m.branch_id))  amount,
                   TO_NUMBER(TO_CHAR(in_end_date, 'RRRR')) year_n,
                   month_n
            FROM(
                SELECT EXTRACT(MONTH FROM d) AS MONTH_N,
                       TO_CHAR(D,'MON') AS MONTH,
                       EXTRACT(YEAR FROM d) AS YEAR
                FROM (
                    SELECT ADD_MONTHS(TO_DATE(acc_supp.get_fiscal_year_start_date(in_end_date)), LEVEL - 1) d
                    FROM DUAL
                    CONNECT BY
                    ADD_MONTHS(TO_DATE(acc_supp.get_fiscal_year_start_date(in_end_date)), LEVEL - 1) <= TO_DATE(CASE WHEN TO_DATE(in_end_date) > SYSDATE THEN TRUNC(SYSDATE,'MM')-1 ELSE TO_DATE(in_end_date) END )
                )
                ) this_year,
                gl_profit_loss_mst m,
                gl_profit_loss_setup lev1,
                gl_profit_loss_setup lev2,
                gl_profit_loss_setup lev3
            WHERE m.level1_setup_id = lev1.id
            AND m.level2_setup_id = lev2.id
            AND m.level3_setup_id = lev3.id     
            AND m.company_id = NVL(in_company_id, m.company_id)
            AND m.branch_id = NVL(in_branch_id, m.branch_id)
            AND in_end_date >= '30-JUN-2024'
            AND m.level2_setup_id >= 101 AND m.level2_setup_id <= 215
        )
        GROUP BY total_fiscal_year,
                 year_n,
                 month_n
        ORDER BY 2,3;
        
        
        CURSOR gross_profit_pct
        IS
        SELECT a.total_fiscal_year,
               a.total_year_n,
               a.total_month_n,
               ROUND(((a.total_amount / NULLIF(b.total_amount,0)) *100),2) gross_pct
        FROM (
        SELECT total_fiscal_year,
               year_n total_year_n,
               month_n total_month_n,
               SUM(amount) total_amount
        FROM (
            SELECT lev1.name lev1,
                   lev3.name lev3,
                   TO_CHAR(d.fiscal_year) total_fiscal_year,
                   CASE 
                       WHEN NVL(m.signed_operator,'##') = '-' THEN -1 * d.amount
                       ELSE d.amount 
                   END amount,
                   d.fiscal_year year_n,
                   0 month_n
            FROM gl_profit_loss_mst m,
                 gl_profit_loss_setup lev1,
                 gl_profit_loss_setup lev2,
                 gl_profit_loss_setup lev3,
                 (
                 SELECT pnl_mst_id,
                        fiscal_year,
                        from_date,
                        to_date,
                        amount,
                        qty
                 FROM gl_profit_loss_prev_amt
                 WHERE from_date >= in_start_date
                 AND to_date <= in_end_date
                 ) d
            WHERE m.pnl_mst_id = d.pnl_mst_id
            AND m.level1_setup_id = lev1.id
            AND m.level2_setup_id = lev2.id
            AND m.level3_setup_id = lev3.id
            AND m.company_id = NVL(in_company_id,m.company_id)
            AND m.branch_id = NVL(in_branch_id,m.branch_id)
            AND m.level2_setup_id >= 101 AND m.level2_setup_id <= 215 
            UNION ALL
            SELECT lev1.name lev1,
                   lev3.name lev3,
                   month||' - '||year fiscal_year,
                   CASE 
                       WHEN NVL(m.signed_operator,'##') = '-' THEN -1 * acc_supp.get_trial_balance (m.pnl_mst_id, this_year.month||'-'||this_year.year , 5, NVL(in_company_id, m.company_id), NVL(in_branch_id, m.branch_id))
                       ELSE acc_supp.get_trial_balance (m.pnl_mst_id, this_year.month||'-'||this_year.year , 5, NVL(in_company_id, m.company_id), NVL(in_branch_id, m.branch_id))
                   END amount,
                   --acc_supp.get_trial_balance (m.pnl_mst_id, this_year.month||'-'||this_year.year , 5, NVL(in_company_id, m.company_id), NVL(in_branch_id, m.branch_id)) amount,
                   TO_NUMBER(TO_CHAR(in_end_date, 'RRRR')) year_n,
                   month_n
            FROM(
                SELECT EXTRACT(MONTH FROM d) AS MONTH_N,
                       TO_CHAR(D,'MON') AS MONTH,
                       EXTRACT(YEAR FROM d) AS YEAR
                FROM (
                    SELECT ADD_MONTHS(TO_DATE(acc_supp.get_fiscal_year_start_date(in_end_date)), LEVEL - 1) d
                    FROM DUAL
                    CONNECT BY
                    ADD_MONTHS(TO_DATE(acc_supp.get_fiscal_year_start_date(in_end_date)), LEVEL - 1) <= TO_DATE(CASE WHEN TO_DATE(in_end_date) > SYSDATE THEN TRUNC(SYSDATE,'MM')-1 ELSE TO_DATE(in_end_date) END )
                )
                ) this_year,
                gl_profit_loss_mst m,
                gl_profit_loss_setup lev1,
                gl_profit_loss_setup lev2,
                gl_profit_loss_setup lev3
            WHERE m.level1_setup_id = lev1.id
            AND m.level2_setup_id = lev2.id
            AND m.level3_setup_id = lev3.id     
            AND m.company_id = NVL(in_company_id, m.company_id)
            AND m.branch_id = NVL(in_branch_id, m.branch_id)
            AND in_end_date >= '30-JUN-2024'
            AND m.level2_setup_id >= 101 AND m.level2_setup_id <= 215
        )
        GROUP BY total_fiscal_year,
                 year_n,
                 month_n
        ) a,
        (
        SELECT total_fiscal_year,
               year_n total_year_n,
               month_n total_month_n,
               SUM(amount) total_amount
        FROM (
            SELECT lev1.name lev1,
                   lev3.name lev3,
                   TO_CHAR(d.fiscal_year) total_fiscal_year,
                   CASE 
                       WHEN NVL(m.signed_operator,'##') = '-' THEN -1 * d.amount
                       ELSE d.amount
                   END amount,
                   d.fiscal_year year_n,
                   0 month_n
            FROM gl_profit_loss_mst m,
                 gl_profit_loss_setup lev1,
                 gl_profit_loss_setup lev2,
                 gl_profit_loss_setup lev3,
                 (
                 SELECT pnl_mst_id,
                        fiscal_year,
                        from_date,
                        to_date,
                        amount,
                        qty
                 FROM gl_profit_loss_prev_amt
                 WHERE from_date >= in_start_date
                 AND to_date <= in_end_date
                 ) d
            WHERE m.pnl_mst_id = d.pnl_mst_id
            AND m.level1_setup_id = lev1.id
            AND m.level2_setup_id = lev2.id
            AND m.level3_setup_id = lev3.id
            AND m.company_id = NVL(in_company_id,m.company_id)
            AND m.branch_id = NVL(in_branch_id,m.branch_id)
            AND m.level2_setup_id >= 101 AND m.level2_setup_id <= 107 
            UNION ALL
            SELECT lev1.name lev1,
                   lev3.name lev3,
                   month||' - '||year fiscal_year,
                   CASE 
                       WHEN NVL(m.signed_operator,'##') = '-' THEN -1 * acc_supp.get_trial_balance (m.pnl_mst_id, this_year.month||'-'||this_year.year , 5, NVL(in_company_id, m.company_id), NVL(in_branch_id, m.branch_id))
                       ELSE acc_supp.get_trial_balance (m.pnl_mst_id, this_year.month||'-'||this_year.year , 5, NVL(in_company_id, m.company_id), NVL(in_branch_id, m.branch_id))
                   END amount,
                   --acc_supp.get_trial_balance (m.pnl_mst_id, this_year.month||'-'||this_year.year , 5, NVL(in_company_id, m.company_id), NVL(in_branch_id, m.branch_id)) amount,
                   TO_NUMBER(TO_CHAR(in_end_date, 'RRRR')) year_n,
                   month_n
            FROM(
                SELECT EXTRACT(MONTH FROM d) AS MONTH_N,
                       TO_CHAR(D,'MON') AS MONTH,
                       EXTRACT(YEAR FROM d) AS YEAR
                FROM (
                    SELECT ADD_MONTHS(TO_DATE(acc_supp.get_fiscal_year_start_date(in_end_date)), LEVEL - 1) d
                    FROM DUAL
                    CONNECT BY
                    ADD_MONTHS(TO_DATE(acc_supp.get_fiscal_year_start_date(in_end_date)), LEVEL - 1) <= TO_DATE(CASE WHEN TO_DATE(in_end_date) > SYSDATE THEN TRUNC(SYSDATE,'MM')-1 ELSE TO_DATE(in_end_date) END )
                )
                ) this_year,
                gl_profit_loss_mst m,
                gl_profit_loss_setup lev1,
                gl_profit_loss_setup lev2,
                gl_profit_loss_setup lev3
            WHERE m.level1_setup_id = lev1.id
            AND m.level2_setup_id = lev2.id
            AND m.level3_setup_id = lev3.id     
            AND m.company_id = NVL(in_company_id, m.company_id)
            AND m.branch_id = NVL(in_branch_id, m.branch_id)
            AND in_end_date >= '30-JUN-2024'
            AND m.level2_setup_id >= 101 AND m.level2_setup_id <= 107
        )
        GROUP BY total_fiscal_year,
                 year_n,
                 month_n) b
        WHERE a.total_fiscal_year = b.total_fiscal_year
        ORDER BY 2,3;
        
        CURSOR net_sales
        IS
        SELECT total_fiscal_year,
               year_n total_year_n,
               month_n total_month_n,
               SUM(amount) total_amount
        FROM (
            SELECT lev1.name lev1,
                   lev3.name lev3,
                   TO_CHAR(d.fiscal_year) total_fiscal_year,
                   CASE 
                       WHEN NVL(m.signed_operator,'##') = '-' THEN -1 * d.amount
                       ELSE d.amount
                   END amount,
                   d.fiscal_year year_n,
                   0 month_n
            FROM gl_profit_loss_mst m,
                 gl_profit_loss_setup lev1,
                 gl_profit_loss_setup lev2,
                 gl_profit_loss_setup lev3,
                 (
                 SELECT pnl_mst_id,
                        fiscal_year,
                        from_date,
                        to_date,
                        amount,
                        qty
                 FROM gl_profit_loss_prev_amt
                 WHERE from_date >= in_start_date
                 AND to_date <= in_end_date
                 ) d
            WHERE m.pnl_mst_id = d.pnl_mst_id
            AND m.level1_setup_id = lev1.id
            AND m.level2_setup_id = lev2.id
            AND m.level3_setup_id = lev3.id
            AND m.company_id = NVL(in_company_id,m.company_id)
            AND m.branch_id = NVL(in_branch_id,m.branch_id)
            AND m.level2_setup_id >= 101 AND m.level2_setup_id <= 107 
            UNION ALL
            SELECT lev1.name lev1,
                   lev3.name lev3,
                   month||' - '||year fiscal_year,
                   CASE 
                       WHEN NVL(m.signed_operator,'##') = '-' THEN -1 * acc_supp.get_trial_balance (m.pnl_mst_id, this_year.month||'-'||this_year.year , 5, NVL(in_company_id, m.company_id), NVL(in_branch_id, m.branch_id))
                       ELSE acc_supp.get_trial_balance (m.pnl_mst_id, this_year.month||'-'||this_year.year , 5, NVL(in_company_id, m.company_id), NVL(in_branch_id, m.branch_id))
                   END amount,
                   --acc_supp.get_trial_balance (m.pnl_mst_id, this_year.month||'-'||this_year.year , 5, NVL(in_company_id, m.company_id), NVL(in_branch_id, m.branch_id)) amount,
                   TO_NUMBER(TO_CHAR(in_end_date, 'RRRR')) year_n,
                   month_n
            FROM(
                SELECT EXTRACT(MONTH FROM d) AS MONTH_N,
                       TO_CHAR(D,'MON') AS MONTH,
                       EXTRACT(YEAR FROM d) AS YEAR
                FROM (
                    SELECT ADD_MONTHS(TO_DATE(acc_supp.get_fiscal_year_start_date(in_end_date)), LEVEL - 1) d
                    FROM DUAL
                    CONNECT BY
                    ADD_MONTHS(TO_DATE(acc_supp.get_fiscal_year_start_date(in_end_date)), LEVEL - 1) <= TO_DATE(CASE WHEN TO_DATE(in_end_date) > SYSDATE THEN TRUNC(SYSDATE,'MM')-1 ELSE TO_DATE(in_end_date) END )
                )
                ) this_year,
                gl_profit_loss_mst m,
                gl_profit_loss_setup lev1,
                gl_profit_loss_setup lev2,
                gl_profit_loss_setup lev3
            WHERE m.level1_setup_id = lev1.id
            AND m.level2_setup_id = lev2.id
            AND m.level3_setup_id = lev3.id     
            AND m.company_id = NVL(in_company_id, m.company_id)
            AND m.branch_id = NVL(in_branch_id, m.branch_id)
            AND in_end_date >= '30-JUN-2024'
            AND m.level2_setup_id >= 101 AND m.level2_setup_id <= 107 
        )
        GROUP BY total_fiscal_year,
                 year_n,
                 month_n
        ORDER BY 2,3;
        
        CURSOR profit_b4_interest
        IS
        SELECT total_fiscal_year,
               year_n total_year_n,
               month_n total_month_n,
               SUM(amount) total_amount
        FROM (
            SELECT lev1.name lev1,
                   lev3.name lev3,
                   TO_CHAR(d.fiscal_year) total_fiscal_year,
                   CASE 
                       WHEN NVL(m.signed_operator,'##') = '-' THEN -1 * d.amount
                       ELSE d.amount
                   END amount,
                   d.fiscal_year year_n,
                   0 month_n
            FROM gl_profit_loss_mst m,
                 gl_profit_loss_setup lev1,
                 gl_profit_loss_setup lev2,
                 gl_profit_loss_setup lev3,
                 (
                 SELECT pnl_mst_id,
                        fiscal_year,
                        from_date,
                        to_date,
                        amount,
                        qty
                 FROM gl_profit_loss_prev_amt
                 WHERE from_date >= in_start_date
                 AND to_date <= in_end_date
                 ) d
            WHERE m.pnl_mst_id = d.pnl_mst_id
            AND m.level1_setup_id = lev1.id
            AND m.level2_setup_id = lev2.id
            AND m.level3_setup_id = lev3.id
            AND m.company_id = NVL(in_company_id,m.company_id)
            AND m.branch_id = NVL(in_branch_id,m.branch_id)
            AND m.level2_setup_id NOT IN (401,402,501,502,601)
            UNION ALL
            SELECT lev1.name lev1,
                   lev3.name lev3,
                   month||' - '||year fiscal_year,
                   CASE 
                       WHEN NVL(m.signed_operator,'##') = '-' THEN -1 * acc_supp.get_trial_balance (m.pnl_mst_id, this_year.month||'-'||this_year.year , 5, NVL(in_company_id, m.company_id), NVL(in_branch_id, m.branch_id))
                       ELSE acc_supp.get_trial_balance (m.pnl_mst_id, this_year.month||'-'||this_year.year , 5, NVL(in_company_id, m.company_id), NVL(in_branch_id, m.branch_id))
                   END amount,
                   --acc_supp.get_trial_balance (m.pnl_mst_id, this_year.month||'-'||this_year.year , 5, NVL(in_company_id, m.company_id), NVL(in_branch_id, m.branch_id)) amount,
                   TO_NUMBER(TO_CHAR(in_end_date, 'RRRR')) year_n,
                   month_n
            FROM(
                SELECT EXTRACT(MONTH FROM d) AS MONTH_N,
                       TO_CHAR(D,'MON') AS MONTH,
                       EXTRACT(YEAR FROM d) AS YEAR
                FROM (
                    SELECT ADD_MONTHS(TO_DATE(acc_supp.get_fiscal_year_start_date(in_end_date)), LEVEL - 1) d
                    FROM DUAL
                    CONNECT BY
                    ADD_MONTHS(TO_DATE(acc_supp.get_fiscal_year_start_date(in_end_date)), LEVEL - 1) <= TO_DATE(CASE WHEN TO_DATE(in_end_date) > SYSDATE THEN TRUNC(SYSDATE,'MM')-1 ELSE TO_DATE(in_end_date) END )
                )
                ) this_year,
                gl_profit_loss_mst m,
                gl_profit_loss_setup lev1,
                gl_profit_loss_setup lev2,
                gl_profit_loss_setup lev3
            WHERE m.level1_setup_id = lev1.id
            AND m.level2_setup_id = lev2.id
            AND m.level3_setup_id = lev3.id     
            AND m.company_id = NVL(in_company_id, m.company_id)
            AND m.branch_id = NVL(in_branch_id, m.branch_id)
            AND in_end_date >= '30-JUN-2024'
            AND m.level2_setup_id NOT IN (401,402,501,502,601)
        )
        GROUP BY total_fiscal_year,
                 year_n,
                 month_n
        ORDER BY 2,3;        
        
        CURSOR profit_b4_dep_income_tx
        IS
        SELECT total_fiscal_year,
               year_n total_year_n,
               month_n total_month_n,
               SUM(amount) total_amount
        FROM (
            SELECT lev1.name lev1,
                   lev3.name lev3,
                   TO_CHAR(d.fiscal_year) total_fiscal_year,
                   CASE 
                       WHEN NVL(m.signed_operator,'##') = '-' THEN -1 * d.amount
                       ELSE d.amount
                   END amount,
                   d.fiscal_year year_n,
                   0 month_n
            FROM gl_profit_loss_mst m,
                 gl_profit_loss_setup lev1,
                 gl_profit_loss_setup lev2,
                 gl_profit_loss_setup lev3,
                 (
                 SELECT pnl_mst_id,
                        fiscal_year,
                        from_date,
                        to_date,
                        amount,
                        qty
                 FROM gl_profit_loss_prev_amt
                 WHERE from_date >= in_start_date
                 AND to_date <= in_end_date
                 ) d
            WHERE m.pnl_mst_id = d.pnl_mst_id
            AND m.level1_setup_id = lev1.id
            AND m.level2_setup_id = lev2.id
            AND m.level3_setup_id = lev3.id
            AND m.company_id = NVL(in_company_id,m.company_id)
            AND m.branch_id = NVL(in_branch_id,m.branch_id)
            AND m.level2_setup_id NOT IN (501,502,601)
            UNION ALL
            SELECT lev1.name lev1,
                   lev3.name lev3,
                   month||' - '||year fiscal_year,
                   CASE 
                       WHEN NVL(m.signed_operator,'##') = '-' THEN -1 * acc_supp.get_trial_balance (m.pnl_mst_id, this_year.month||'-'||this_year.year , 5, NVL(in_company_id, m.company_id), NVL(in_branch_id, m.branch_id))
                       ELSE acc_supp.get_trial_balance (m.pnl_mst_id, this_year.month||'-'||this_year.year , 5, NVL(in_company_id, m.company_id), NVL(in_branch_id, m.branch_id))
                   END amount,
                   --acc_supp.get_trial_balance (m.pnl_mst_id, this_year.month||'-'||this_year.year , 5, NVL(in_company_id, m.company_id), NVL(in_branch_id, m.branch_id)) amount,
                   TO_NUMBER(TO_CHAR(in_end_date, 'RRRR')) year_n,
                   month_n
            FROM(
                SELECT EXTRACT(MONTH FROM d) AS MONTH_N,
                       TO_CHAR(D,'MON') AS MONTH,
                       EXTRACT(YEAR FROM d) AS YEAR
                FROM (
                    SELECT ADD_MONTHS(TO_DATE(acc_supp.get_fiscal_year_start_date(in_end_date)), LEVEL - 1) d
                    FROM DUAL
                    CONNECT BY
                    ADD_MONTHS(TO_DATE(acc_supp.get_fiscal_year_start_date(in_end_date)), LEVEL - 1) <= TO_DATE(CASE WHEN TO_DATE(in_end_date) > SYSDATE THEN TRUNC(SYSDATE,'MM')-1 ELSE TO_DATE(in_end_date) END )
                )
                ) this_year,
                gl_profit_loss_mst m,
                gl_profit_loss_setup lev1,
                gl_profit_loss_setup lev2,
                gl_profit_loss_setup lev3
            WHERE m.level1_setup_id = lev1.id
            AND m.level2_setup_id = lev2.id
            AND m.level3_setup_id = lev3.id     
            AND m.company_id = NVL(in_company_id, m.company_id)
            AND m.branch_id = NVL(in_branch_id, m.branch_id)
            AND in_end_date >= '30-JUN-2024'
            AND m.level2_setup_id NOT IN (501,502,601)
        )
        GROUP BY total_fiscal_year,
                 year_n,
                 month_n
        ORDER BY 2,3;
        
        CURSOR profit_b4_income_tx
        IS
        SELECT total_fiscal_year,
               year_n total_year_n,
               month_n total_month_n,
               SUM(amount) total_amount
        FROM (
            SELECT lev1.name lev1,
                   lev3.name lev3,
                   TO_CHAR(d.fiscal_year) total_fiscal_year,
                   CASE 
                       WHEN NVL(m.signed_operator,'##') = '-' THEN -1 * d.amount
                       ELSE d.amount
                   END amount,
                   d.fiscal_year year_n,
                   0 month_n
            FROM gl_profit_loss_mst m,
                 gl_profit_loss_setup lev1,
                 gl_profit_loss_setup lev2,
                 gl_profit_loss_setup lev3,
                 (
                 SELECT pnl_mst_id,
                        fiscal_year,
                        from_date,
                        to_date,
                        amount,
                        qty
                 FROM gl_profit_loss_prev_amt
                 WHERE from_date >= in_start_date
                 AND to_date <= in_end_date
                 ) d
            WHERE m.pnl_mst_id = d.pnl_mst_id
            AND m.level1_setup_id = lev1.id
            AND m.level2_setup_id = lev2.id
            AND m.level3_setup_id = lev3.id
            AND m.company_id = NVL(in_company_id,m.company_id)
            AND m.branch_id = NVL(in_branch_id,m.branch_id)
            AND m.level2_setup_id <> 601
            UNION ALL
            SELECT lev1.name lev1,
                   lev3.name lev3,
                   month||' - '||year fiscal_year,
                   CASE 
                       WHEN NVL(m.signed_operator,'##') = '-' THEN -1 * acc_supp.get_trial_balance (m.pnl_mst_id, this_year.month||'-'||this_year.year , 5, NVL(in_company_id, m.company_id), NVL(in_branch_id, m.branch_id))
                       ELSE acc_supp.get_trial_balance (m.pnl_mst_id, this_year.month||'-'||this_year.year , 5, NVL(in_company_id, m.company_id), NVL(in_branch_id, m.branch_id))
                   END amount,
                   --acc_supp.get_trial_balance (m.pnl_mst_id, this_year.month||'-'||this_year.year , 5, NVL(in_company_id, m.company_id), NVL(in_branch_id, m.branch_id)) amount,
                   TO_NUMBER(TO_CHAR(in_end_date, 'RRRR')) year_n,
                   month_n
            FROM(
                SELECT EXTRACT(MONTH FROM d) AS MONTH_N,
                       TO_CHAR(D,'MON') AS MONTH,
                       EXTRACT(YEAR FROM d) AS YEAR
                FROM (
                    SELECT ADD_MONTHS(TO_DATE(acc_supp.get_fiscal_year_start_date(in_end_date)), LEVEL - 1) d
                    FROM DUAL
                    CONNECT BY
                    ADD_MONTHS(TO_DATE(acc_supp.get_fiscal_year_start_date(in_end_date)), LEVEL - 1) <= TO_DATE(CASE WHEN TO_DATE(in_end_date) > SYSDATE THEN TRUNC(SYSDATE,'MM')-1 ELSE TO_DATE(in_end_date) END )
                )
                ) this_year,
                gl_profit_loss_mst m,
                gl_profit_loss_setup lev1,
                gl_profit_loss_setup lev2,
                gl_profit_loss_setup lev3
            WHERE m.level1_setup_id = lev1.id
            AND m.level2_setup_id = lev2.id
            AND m.level3_setup_id = lev3.id     
            AND m.company_id = NVL(in_company_id, m.company_id)
            AND m.branch_id = NVL(in_branch_id, m.branch_id)
            AND in_end_date >= '30-JUN-2024'
            AND m.level2_setup_id <> 601
        )
        GROUP BY total_fiscal_year,
                 year_n,
                 month_n
        ORDER BY 2,3;
        
    BEGIN

        FOR i IN profit_loss_qty LOOP
            INSERT INTO gl_profit_loss_qty  (
                lev1, 
                lev3, 
                lev3_id, 
                fiscal_year, 
                qty, 
                cfy_qty,
                pnl_mst_id, 
                year_n, 
                month_n, 
                level1_serial, 
                level2_serial, 
                from_date, 
                to_date, 
                company_id, 
                branch_id
            )
            VALUES (
                i.lev1, 
                i.lev3, 
                i.lev3_id, 
                i.fiscal_year, 
                i.qty, 
                i.cfy_qty,
                i.pnl_mst_id, 
                i.year_n, 
                i.month_n, 
                i.level1_serial, 
                i.level2_serial, 
                null, 
                null, 
                in_company_id, 
                in_branch_id
            );
            
        END LOOP;
        
        COMMIT;
        
        FOR j IN profit_loss_amt LOOP
            INSERT INTO gl_profit_loss_amt (
                lev1, 
                lev3, 
                fiscal_year, 
                amount, 
                cfy_amt,
                pnl_mst_id, 
                year_n, 
                month_n, 
                level1_serial, 
                level2_serial, 
                from_date, 
                to_date, 
                company_id, 
                branch_id,
                signed_operator,
                lev3_id
            )
            VALUES (
                j.lev1, 
                j.lev3, 
                j.fiscal_year, 
                j.amount,
                j.cfy_amt, 
                j.pnl_mst_id, 
                j.year_n, 
                j.month_n, 
                j.level1_serial, 
                j.level2_serial, 
                null,
                null,
                in_company_id, 
                in_branch_id,
                j.signed_operator,
                j.level3_setup_id
            );
        END LOOP;
        
        COMMIT;
        
        FOR k IN profit_loss_amt_sum LOOP
            INSERT INTO gl_profit_loss_amt_sum ( 
                total_fiscal_year, 
                total_year_n, 
                total_month_n, 
                total_amount, 
                from_date, 
                to_date, 
                company_id, 
                branch_id
            )
            VALUES (
                k.total_fiscal_year, 
                k.total_year_n, 
                k.total_month_n, 
                k.total_amount, 
                null,
                null,
                in_company_id, 
                in_branch_id
            );
            
        END LOOP;
        
        COMMIT;
        
        FOR m IN gross_profit LOOP
            INSERT INTO gl_profit_loss_gross_profit (
                total_fiscal_year, 
                total_year_n, 
                total_month_n, 
                total_amount, 
                from_date, 
                to_date, 
                company_id, 
                branch_id
            )
            VALUES (
                m.total_fiscal_year, 
                m.total_year_n, 
                m.total_month_n, 
                m.total_amount,         
                NULL,
                NULL,
                in_company_id,
                in_branch_id
            );
            
        END LOOP;
        COMMIT;
        
        FOR n IN gross_profit_pct LOOP
            INSERT INTO gl_pnl_gross_profit_pct (
                total_fiscal_year, 
                total_year_n, 
                total_month_n, 
                gross_pct, 
                from_date, 
                to_date, 
                company_id, 
                branch_id
            )
            VALUES (
                n.total_fiscal_year, 
                n.total_year_n, 
                n.total_month_n, 
                n.gross_pct, 
                null,
                null,
                in_company_id,
                in_branch_id
            );
        END LOOP;
        COMMIT;
        
        FOR x IN net_sales LOOP
            INSERT INTO gl_profit_loss_net_sales (
                total_fiscal_year, 
                total_year_n, 
                total_month_n, 
                total_amount, 
                from_date, 
                to_date, 
                company_id, 
                branch_id
            )
            VALUES (
                x.total_fiscal_year, 
                x.total_year_n, 
                x.total_month_n, 
                x.total_amount, 
                null,
                null,
                in_company_id,
                in_branch_id
            );
        END LOOP;
        
        COMMIT;
        
        FOR a IN profit_b4_interest LOOP
            INSERT INTO gl_profit_b4_interest (
                total_fiscal_year, 
                total_year_n, 
                total_month_n, 
                total_amount, 
                from_date, 
                to_date, 
                company_id, 
                branch_id
            )
            VALUES (
                a.total_fiscal_year, 
                a.total_year_n, 
                a.total_month_n, 
                a.total_amount, 
                null,
                null,
                in_company_id,
                in_branch_id
            );
        END LOOP;
        
        COMMIT;
        
        FOR y IN profit_b4_dep_income_tx LOOP
            INSERT INTO gl_profit_b4_dep_income_tx (
                total_fiscal_year, 
                total_year_n, 
                total_month_n, 
                total_amount, 
                from_date, 
                to_date, 
                company_id, 
                branch_id
            )
            VALUES (
                y.total_fiscal_year, 
                y.total_year_n, 
                y.total_month_n, 
                y.total_amount, 
                null,
                null,
                in_company_id,
                in_branch_id
            );
        END LOOP;
        
        COMMIT;
        
        FOR z IN profit_b4_income_tx LOOP
            INSERT INTO gl_profit_b4_income_tx (
                total_fiscal_year, 
                total_year_n, 
                total_month_n, 
                total_amount, 
                from_date, 
                to_date, 
                company_id, 
                branch_id
            )
            VALUES (
                z.total_fiscal_year, 
                z.total_year_n, 
                z.total_month_n, 
                z.total_amount, 
                null,
                null,
                in_company_id,
                in_branch_id
            );
        END LOOP;
        
        COMMIT;
        
    EXCEPTION
        WHEN OTHERS THEN
        NULL;
    END;
    
    /*
        -- This procedure is added in scheduler for getting profit and loss data.
           For making the report faster.
    */
    
    PROCEDURE populate_gl_profit_loss
    IS
        CURSOR branch
        IS
        SELECT company_no,
               branch_id
        FROM sys_branches
        WHERE active = 'Y';
        
        CURSOR c2 
        IS
        SELECT MIN(start_date),
               MAX(end_date)
        FROM gl_fiscal_year;
        
        l_start_date DATE;
        l_end_date DATE;
    BEGIN
    
        DELETE FROM gl_profit_loss_qty;
        DELETE FROM gl_profit_loss_amt;
        DELETE FROM gl_profit_loss_amt_sum;
        DELETE FROM gl_profit_loss_gross_profit;
        DELETE FROM gl_pnl_gross_profit_pct;
        DELETE FROM gl_profit_loss_net_sales;
        DELETE FROM gl_profit_b4_dep_income_tx;
        DELETE FROM gl_profit_b4_income_tx;
        DELETE FROM gl_profit_b4_interest;
        
        COMMIT;
        
        OPEN c2;
            FETCH c2 INTO l_start_date, l_end_date;
        CLOSE c2;
        
        FOR m IN branch LOOP
            acc_supp.ins_gl_profit_loss_data (
                in_start_date    => l_start_date,
                in_end_date      => l_end_date,
                in_company_id    => m.company_no,
                in_branch_id     => m.branch_id
            );
        END LOOP;
        
        COMMIT;
        
    EXCEPTION
        WHEN OTHERS THEN
        NULL;
    END;
    
    FUNCTION get_net_sales_cfy (
        in_end_date      IN     DATE,
        in_company_id    IN     NUMBER,
        in_branch_id     IN     VARCHAR2
    ) RETURN NUMBER
    IS
        l_amt NUMBER := 0;
    BEGIN
        IF in_end_date < '30-JUN-2024' THEN
            RETURN 0;
        ELSE
            SELECT SUM(NVL(total_amount,0))
            INTO l_amt
            FROM gl_profit_loss_net_sales
            WHERE INSTR(total_fiscal_year, '-') > 0
            AND company_id = NVL(in_company_id,company_id)
            AND branch_id = NVL(in_branch_id,branch_id)
            AND total_fiscal_year <> TO_CHAR(SYSDATE, 'MON - RRRR');
        END IF;     
        
        RETURN l_amt;
        
    EXCEPTION
        WHEN OTHERS THEN
        RETURN 0;
    END;
    
    FUNCTION get_gross_sales_cfy (
        in_end_date      IN     DATE,
        in_company_id    IN     NUMBER,
        in_branch_id     IN     VARCHAR2
    ) RETURN NUMBER
    IS
        l_amt NUMBER := 0;
    BEGIN
        IF in_end_date < '30-JUN-2024' THEN
            RETURN 0;
        ELSE
            SELECT SUM(NVL(total_amount,0))
            INTO l_amt
            FROM gl_profit_loss_gross_profit
            WHERE INSTR(total_fiscal_year, '-') > 0
            AND company_id = NVL(in_company_id,company_id)
            AND branch_id = NVL(in_branch_id,branch_id)
            AND total_fiscal_year <> TO_CHAR(SYSDATE, 'MON - RRRR');
        END IF;     
        
        RETURN l_amt;
        
    EXCEPTION
        WHEN OTHERS THEN
        RETURN 0;
    END;
    
    
    FUNCTION get_profit_b4_interest_cfy (
        in_end_date      IN     DATE,
        in_company_id    IN     NUMBER,
        in_branch_id     IN     VARCHAR2
    ) RETURN NUMBER
    IS
        l_amt NUMBER;
    BEGIN
        IF in_end_date < '30-JUN-2024' THEN
            RETURN 0;
        ELSE
            SELECT SUM(NVL(total_amount,0))
            INTO l_amt
            FROM gl_profit_b4_interest
            WHERE INSTR(total_fiscal_year, '-') > 0
            AND company_id = NVL(in_company_id,company_id)
            AND branch_id = NVL(in_branch_id,branch_id)
            AND total_fiscal_year <> TO_CHAR(SYSDATE, 'MON - RRRR');
        END IF;     
        
        RETURN l_amt;
    
    EXCEPTION
        WHEN OTHERS THEN
        RETURN 0;
    END;
    
    FUNCTION get_profit_b4_dep_cfy (
        in_end_date      IN     DATE,
        in_company_id    IN     NUMBER,
        in_branch_id     IN     VARCHAR2
    ) RETURN NUMBER
    IS
        l_amt NUMBER;
    BEGIN
        IF in_end_date < '30-JUN-2024' THEN
            RETURN 0;
        ELSE
            SELECT SUM(NVL(total_amount,0))
            INTO l_amt
            FROM gl_profit_b4_dep_income_tx
            WHERE INSTR(total_fiscal_year, '-') > 0
            AND company_id = NVL(in_company_id,company_id)
            AND branch_id = NVL(in_branch_id,branch_id)
            AND total_fiscal_year <> TO_CHAR(SYSDATE, 'MON - RRRR');
        END IF;     
        
        RETURN l_amt;
    
    EXCEPTION
        WHEN OTHERS THEN
        RETURN 0;
    END;
    
    
    FUNCTION get_profit_b4_inctx_cfy (
        in_end_date      IN     DATE,
        in_company_id    IN     NUMBER,
        in_branch_id     IN     VARCHAR2
    ) RETURN NUMBER
    IS
        l_amt NUMBER;
    BEGIN
        IF in_end_date < '30-JUN-2024' THEN
            RETURN 0;
        ELSE
            SELECT SUM(NVL(total_amount,0))
            INTO l_amt
            FROM gl_profit_b4_income_tx
            WHERE INSTR(total_fiscal_year, '-') > 0
            AND company_id = NVL(in_company_id,company_id)
            AND branch_id = NVL(in_branch_id,branch_id)
            AND total_fiscal_year <> TO_CHAR(SYSDATE, 'MON - RRRR');
        END IF;     
        
        RETURN l_amt;
    
    EXCEPTION
        WHEN OTHERS THEN
        RETURN 0;
    END;
    
    
    FUNCTION get_profit_after_inctx_cfy (
        in_end_date      IN     DATE,
        in_company_id    IN     NUMBER,
        in_branch_id     IN     VARCHAR2
    ) RETURN NUMBER
    IS
        l_amt NUMBER;
    BEGIN
        IF in_end_date < '30-JUN-2024' THEN
            RETURN 0;
        ELSE
            SELECT SUM(NVL(total_amount,0))
            INTO l_amt
            FROM gl_profit_loss_amt_sum
            WHERE INSTR(total_fiscal_year, '-') > 0
            AND company_id = NVL(in_company_id,company_id)
            AND branch_id = NVL(in_branch_id,branch_id)
            AND total_fiscal_year <> TO_CHAR(SYSDATE, 'MON - RRRR');
        END IF;     
        
        RETURN l_amt;
    
    EXCEPTION
        WHEN OTHERS THEN
        RETURN 0;
    END;
    
    
    FUNCTION get_net_sales (
        in_start_date    IN     DATE,
        in_end_date      IN     DATE,
        in_company_id    IN     NUMBER,
        in_branch_id     IN     VARCHAR2
    ) RETURN NUMBER
    IS
        CURSOR c1
        IS
        SELECT SUM(total_amount) total_amount
        FROM gl_profit_loss_net_sales
        WHERE company_id = NVL(in_company_id,company_id)
        AND branch_id = NVL(in_branch_id,branch_id)
        AND total_year_n >= TO_NUMBER(TO_CHAR(in_start_date,'rrrr'))+1
        AND total_year_n <= TO_NUMBER(TO_CHAR(in_end_date,'rrrr'))
        AND total_fiscal_year <> TO_CHAR(SYSDATE, 'MON - RRRR');
        
        l_amt NUMBER;
    BEGIN
        OPEN c1;
            FETCH c1 INTO l_amt;
        CLOSE c1;
        
        RETURN l_amt;
        
    EXCEPTION
        WHEN OTHERS THEN
        RETURN 0;
    END;
    
    FUNCTION get_gross_profit (
        in_start_date    IN     DATE,
        in_end_date      IN     DATE,
        in_company_id    IN     NUMBER,
        in_branch_id     IN     VARCHAR2
    ) RETURN NUMBER
    IS
        CURSOR c1
        IS
        SELECT SUM(total_amount) total_amount
        FROM gl_profit_loss_gross_profit
        WHERE company_id = NVL(in_company_id,company_id)
        AND branch_id = NVL(in_branch_id,branch_id)
        AND total_year_n >= TO_NUMBER(TO_CHAR(in_start_date,'rrrr'))+1
        AND total_year_n <= TO_NUMBER(TO_CHAR(in_end_date,'rrrr'))
        AND total_fiscal_year <> TO_CHAR(SYSDATE, 'MON - RRRR');
        
    l_amt NUMBER;
    
    BEGIN
        OPEN c1;
            FETCH c1 INTO l_amt;
        CLOSE c1;
        
        RETURN l_amt;
    EXCEPTION
        WHEN OTHERS THEN
        RETURN 0;
    END;
    
    FUNCTION get_profit_before_itd (
        in_start_date    IN     DATE,
        in_end_date      IN     DATE,
        in_company_id    IN     NUMBER,
        in_branch_id     IN     VARCHAR2
    ) RETURN NUMBER
    IS
        CURSOR c1
        IS
        SELECT SUM(total_amount) total_amount
        FROM gl_profit_b4_interest
        WHERE company_id = NVL(in_company_id, company_id)
        AND branch_id = NVL(in_branch_id,branch_id)
        AND total_year_n >= to_number(to_char(in_START_DATE,'rrrr'))+1
        AND total_year_n <= to_number(to_char(IN_END_DATE,'rrrr'))
        AND total_fiscal_year <> TO_CHAR(SYSDATE, 'MON - RRRR');
        
        l_amt NUMBER;
    
    BEGIN
        OPEN c1;
            FETCH c1 INTO l_amt;
        CLOSE c1;
        
        RETURN l_amt;
    EXCEPTION
        WHEN OTHERS THEN
        RETURN 0;
    END;
    
    
    FUNCTION get_profit_before_di (
        in_start_date    IN     DATE,
        in_end_date      IN     DATE,
        in_company_id    IN     NUMBER,
        in_branch_id     IN     VARCHAR2
    ) RETURN NUMBER
    IS
        CURSOR c1
        IS
        SELECT SUM(total_amount) total_amount
        FROM gl_profit_b4_dep_income_tx
        WHERE company_id = NVL(in_company_id,company_id)
        AND branch_id = NVL(in_branch_id,branch_id)
        AND total_year_n >= to_number(to_char(in_start_date,'rrrr'))+1
        AND total_year_n <= to_number(to_char(in_end_date,'rrrr'))
        AND total_fiscal_year <> TO_CHAR(SYSDATE, 'MON - RRRR');
        
        l_amt NUMBER;
    
     BEGIN
        OPEN c1;
            FETCH c1 INTO l_amt;
        CLOSE c1;
        
        RETURN l_amt;
    EXCEPTION
        WHEN OTHERS THEN
        RETURN 0;
    END;
    
    FUNCTION get_profit_before_it (
        in_start_date    IN     DATE,
        in_end_date      IN     DATE,
        in_company_id    IN     NUMBER,
        in_branch_id     IN     VARCHAR2
    ) RETURN NUMBER
    IS
        CURSOR c1
        IS
        SELECT SUM(total_amount) total_amount
        FROM gl_profit_b4_income_tx
        WHERE company_id = NVL(in_company_id, company_id)
        AND branch_id = NVL(in_branch_id,branch_id)
        AND total_year_n >= to_number(to_char(in_start_DATE,'rrrr'))+1
        AND total_year_n <= to_number(to_char(in_end_DATE,'rrrr'))
        AND total_fiscal_year <> TO_CHAR(SYSDATE, 'MON - RRRR');
        
        l_amt NUMBER;
    BEGIN
        OPEN c1;
            FETCH c1 INTO l_amt;
        CLOSE c1;
        
        RETURN l_amt;
    EXCEPTION
        WHEN OTHERS THEN
        RETURN 0;
    END;
    
    FUNCTION get_profit_after_it (
        in_start_date    IN     DATE,
        in_end_date      IN     DATE,
        in_company_id    IN     NUMBER,
        in_branch_id     IN     VARCHAR2
    ) RETURN NUMBER
    IS
        CURSOR c1
        IS
        SELECT SUM(total_amount) total_amount
        FROM gl_profit_loss_amt_sum
        WHERE company_id = NVL(in_company_id, company_id)
        AND branch_id = NVL(in_branch_id,branch_id)
        AND total_year_n >= to_number(to_char(in_start_DATE,'rrrr'))+1
        AND total_year_n <= to_number(to_char(in_end_DATE,'rrrr'))
        AND total_fiscal_year <> TO_CHAR(SYSDATE, 'MON - RRRR');
  
        l_amt NUMBER;
    BEGIN
        OPEN c1;
            FETCH c1 INTO l_amt;
        CLOSE c1;
        
        RETURN l_amt;
    EXCEPTION
        WHEN OTHERS THEN
        RETURN 0;
    END;
    
    FUNCTION ebitda_usd_exchange_rate 
    RETURN NUMBER
    IS
        l_rate NUMBER;
    BEGIN
        l_rate := 102;
        RETURN l_rate;
    END;
    
    FUNCTION get_ebitda_mt_qty (
        in_start_date    IN     DATE,
        in_end_date      IN     DATE
    ) RETURN NUMBER
    IS
        CURSOR c1
        IS
        SELECT SUM(NVL(qty_kgs,0)) / 1000
        FROM mapics_sales s,
             inv_items i
        WHERE s.invoice_date BETWEEN in_start_date AND in_end_date
        AND i.item_id IN (1,8,9,10,11,16,17,18,19,605,606)
        AND s.item_code = SUBSTR(i.old_item_code,3,5);
        l_mt_qty NUMBER;
    BEGIN
        OPEN c1;
            FETCH c1 INTO l_mt_qty;
        CLOSE c1;
        RETURN l_mt_qty;
    EXCEPTION
        WHEN OTHERS THEN
        RETURN 0;
    END;
    
END acc_supp;
/
