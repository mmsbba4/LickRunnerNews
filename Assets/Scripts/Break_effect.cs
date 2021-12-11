using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Break_effect : MonoBehaviour
{
    public Rigidbody rbb;
    private void OnEnable()
    {
        rbb.transform.parent = null;
        //rbb.velocity = Vector3.back;
        Destroy(rbb.gameObject, 3);
    }
    public void OnDestro()
    {
        Destroy(gameObject);
    }
}
