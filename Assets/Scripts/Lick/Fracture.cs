using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Fracture : MonoBehaviour
{
    public void ActiveFraction()
    {
        transform.localPosition = new Vector3(transform.localPosition.x, transform.localPosition.y+ 0.2f, transform.localPosition.z);
        GetComponent<Rigidbody>().isKinematic = false; 

    } 
}
