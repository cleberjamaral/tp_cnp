products([["Banana",1],["Apple",2],["Pineapple",2.5]]).
margin(2).
	
//Submit proposal plan, sends to the initiator my product offers
+!sendProposals(RequestedItem)[source(X)] : true <-
	?products(List);
    ?margin(Z);
	+replying(X,false);
	for (.member(Item,List)) {
		.nth(0,Item,Name);
		.nth(1,Item,Price);
		if (RequestedItem == Name) {
			.random(Y);
			tp_cnp.formatCurrency(Y*Z+Price,PPrice);
			.print("Product: ",Name," base price $",Price, " sales price $",PPrice);
			.send(X,tell,newProposal(Name,PPrice));
			-+replying(X,true);
		}
	}
	?replying(A,B);
	if (A == X & not B) {
		.send(X,tell,noProposal(RequestedItem));
	}
	-replying(X,_).		


+accepted(Product,Price)[source(X)] : true <-
	.print("Accepted by ",X,": ",Product,"  $",Price).

+rejected(Product,Price)[source(X)] : true <-
	.print("Rejected by ",X,": ",Product,"  $",Price).
