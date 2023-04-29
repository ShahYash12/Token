import React, { useState } from "react";
import {token} from "../../../declarations/token";
import {Principal} from "@dfinity/principal";

function Transfer() {
  
  const [recipientId , setId] = useState("");
  const [amount , setAmount] = useState("");
  const [isDisabled , setDisable] = useState(false)
  const [buttonText , setText]= useState(" Transfer")

  async function handleClick() {
    setDisable(true);
    
    const recipient = Principal.fromText(recipientId)
    const amountToTransfer = Number(amount);
    const result = await token.transfer(recipient, amountToTransfer )
     
    setText(result);

    setDisable(false);
    
  }

  return (
    <div className="window white">
      <div className="transfer">
        <fieldset>
          <legend>To Account:</legend>
          <ul>
            <li>
              <input
                type="text"
                id="transfer-to-id"
                value={recipientId}
                onChange={(e) => setId(e.target.value)}

              />
            </li>
          </ul>
        </fieldset>
        <fieldset>
          <legend>Amount:</legend>
          <ul>
            <li>
              <input
                type="number"
                id="amount"
                value={amount}
                onChange={(e) => setAmount(e.target.value)}

              />
            </li>
          </ul>
        </fieldset>
        <p className="trade-buttons">
          <button id="btn-transfer" onClick={handleClick} disabled={isDisabled} >
            {buttonText}
          </button>
        </p>
      </div>
    </div>
  );
}

export default Transfer;
